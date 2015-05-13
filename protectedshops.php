<?php
/**
 * protectedshops Module
 *
 * Copyright (c) 2011 touchdesign
 *
 * @category  Tools
 * @author    Christin Gruber, <www.touchdesign.de>
 * @copyright 02.02.2011, touchdesign
 * @link      http://www.touchdesign.de/loesungen/prestashop/protectedshops.htm
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 *
 * Description:
 *
 * Protected Shops AGB Connect module by touchdesign
 *
 * --
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@touchdesign.de so we can send you a copy immediately.
 */

if (!defined('_PS_VERSION_'))
	exit;

class Protectedshops extends Module
{
	private $html = '';

	public function __construct()
	{
		$this->name = 'protectedshops';
		$this->tab = 'others';
		$this->version = '2.1.0';
		$this->author = 'touchdesign';
		parent::__construct();
		$this->page = basename(__FILE__, '.php');
		$this->displayName = $this->l('Protected Shops');
		$this->description = $this->l('Protected Shops AGB connect module');
		$this->confirmUninstall = $this->l('Are you sure you want to delete your details?');
        $this->module_key = '556bb246da8b8eae0673aa1ca8862418';
		/* Backward compatibility */
		if (version_compare(_PS_VERSION_, '1.5', '<'))
			require(_PS_MODULE_DIR_.$this->name.'/backward_compatibility/backward.php');
	}

	public function install()
	{
		if (!parent::install()
			|| !Configuration::updateValue('PROTECTEDSHOPS_ALERT', 'info@protectedshops.de')
			|| !Configuration::updateValue('PROTECTEDSHOPS_SHOPID', '')
			|| !Configuration::updateValue('PROTECTEDSHOPS_BLOCK_LOGO', 'Y')
			|| !Configuration::updateValue('PROTECTEDSHOPS_FORMAT', 'html-lite')
			|| !Configuration::updateValue('PROTECTEDSHOPS_AUTOMATIC_UPDATE', '0')
			|| !$this->registerHook('leftColumn')
			|| !$this->registerHook('footer')
			|| !$this->registerHook('newOrder')
			|| !$this->registerHook('orderConfirmation')
			|| !$this->registerHook('displayHeader'))
			return false;

		$sql = 'CREATE TABLE '._DB_PREFIX_.'touchdesign_protectedshops_document(
			document VARCHAR(255) NOT NULL,
			cms_id INT(11) NOT NULL,
			mail SMALLINT(1),
			pdf MEDIUMBLOB NULL,
			css MEDIUMBLOB NULL,
			sync_date DATETIME NULL,
			refresh_date DATETIME NULL,
			failed INT(11) NOT NULL,
			UNIQUE (document)
		) ENGINE=MyISAM default CHARSET=utf8';
		if (!Db::getInstance()->Execute($sql))
			return false;

		return true;
	}

	public function uninstall()
	{
		if (!Configuration::deleteByName('PROTECTEDSHOPS_ALERT')
			|| !Configuration::deleteByName('PROTECTEDSHOPS_SHOPID')
			|| !Configuration::deleteByName('PROTECTEDSHOPS_BLOCK_LOGO')
			|| !Configuration::deleteByName('PROTECTEDSHOPS_FORMAT')
			|| !Configuration::deleteByName('PROTECTEDSHOPS_AUTOMATIC_UPDATE')
			|| !parent::uninstall())
			return false;

		$sql = 'DROP TABLE '._DB_PREFIX_.'touchdesign_protectedshops_document';
		if (!Db::getInstance()->Execute($sql))
			return false;
		return true;
	}

	private function postValidation()
	{
		if (Tools::getValue('submitUpdate'))
			if (!Tools::getValue('PROTECTEDSHOPS_SHOPID'))
				$this->_errors[] = $this->l('Protected Shops "ShopId" is required.');
	}

	public function getContent()
	{
		$this->html = '<h2>'.$this->displayName.'</h2>';
		if (Tools::isSubmit('submitUpdate'))
		{
			Configuration::updateValue('PROTECTEDSHOPS_SHOPID', Tools::getValue('PROTECTEDSHOPS_SHOPID'));
			Configuration::updateValue('PROTECTEDSHOPS_BLOCK_LOGO', Tools::getValue('PROTECTEDSHOPS_BLOCK_LOGO'));
			Configuration::updateValue('PROTECTEDSHOPS_FORMAT', Tools::getValue('PROTECTEDSHOPS_FORMAT'));
			Configuration::updateValue('PROTECTEDSHOPS_AUTOMATIC_UPDATE', Tools::getValue('PROTECTEDSHOPS_AUTOMATIC_UPDATE'));
		}

		if (Tools::isSubmit('submitDocumentUpdate'))
			if ($this->updateDocuments())
				$this->refreshDocuments(true);

		$this->postValidation();
		if (isset($this->_errors) && count($this->_errors))
			foreach ($this->_errors as $err)
				$this->html .= $this->displayError($err);
		elseif (Tools::isSubmit('submitUpdate') && !count($this->_errors))
			$this->html .= $this->displayConfirmation($this->l('Settings updated!'));
		elseif (Tools::isSubmit('submitDocumentUpdate') && !count($this->_errors))
			$this->html .= $this->displayConfirmation($this->l('Documents successfully updated!'));

		return $this->html.$this->displayForm();
	}

	private function displayForm()
	{
		$cms_pages = CMS::listCms(Configuration::get('PS_LANG_DEFAULT'));
		$cms_items = array('' => 'None');
		foreach ($cms_pages as $page)
			$cms_items[$page['id_cms']] = $page['meta_title'];

		$template_vars = array(
				'action' => $_SERVER['REQUEST_URI'],
				'config' => Configuration::getMultiple(array(
						'PROTECTEDSHOPS_SHOPID',
						'PROTECTEDSHOPS_BLOCK_LOGO',
						'PROTECTEDSHOPS_FORMAT',
						'PROTECTEDSHOPS_AUTOMATIC_UPDATE')
				),
				'documents' => array(
						'used' => $this->getUsedDocuments(),
						'info' => Configuration::get('PROTECTEDSHOPS_SHOPID') ? $this->getDocumentInfo() : null,
						'cms_items' => $cms_items
				)
		);

		$this->context->smarty->assign(array('protectedshops' => $template_vars));

		return $this->display(__FILE__, 'views/templates/admin/display_form.tpl');
	}

	public function hookLeftColumn($params)
	{
		if (Configuration::get('PROTECTEDSHOPS_BLOCK_LOGO') == 'N')
			return false;

		$this->context->smarty->assign('protectedshops_shopid', Configuration::get('PROTECTEDSHOPS_SHOPID'));

		return $this->display(__FILE__, 'views/templates/hook/blockprotectedshopslogo.tpl');
	}

	public function hookFooter($params)
	{
		if (!Configuration::get('PROTECTEDSHOPS_AUTOMATIC_UPDATE'))
			return false;

		return $this->display(__FILE__, 'views/templates/hook/update.tpl');
	}

	public function hookDisplayHeader($params)
	{
		if (!Tools::getValue('controller') || Tools::getValue('controller') != 'cms' || !Tools::getValue('id_cms'))
			return false;

		$css = Db::getInstance()->getValue('SELECT css FROM '._DB_PREFIX_
				.'touchdesign_protectedshops_document WHERE cms_id='.(int)Tools::getValue('id_cms'));

		if ($css)
		{
			$this->context->smarty->assign('css', $css);
			return $this->display(__FILE__, 'views/templates/hook/header.tpl');
		}

		return false;
	}

	public function hookNewOrder($params)
	{
		$this->sendDocument($params);

		return true;
	}

	public function getUsedDocuments()
	{
		$documents = Db::getInstance()->executeS('SELECT * FROM '._DB_PREFIX_.'touchdesign_protectedshops_document');

		$result = array();
		foreach ($documents as $doc)
			$result[$doc['document']] = $doc;

		return $result;
	}

	public function hasFailed()
	{
		foreach ($this->getUsedDocuments() as $doc)
			if (!empty($doc['failed']))
				return true;
		return false;
	}

	private function sendDocument($params)
	{
		$documents = $this->getUsedDocuments();
		if (!$documents)
			return false;

		$template_vars = array(
				'{firstname}' => $params['customer']->firstname,
				'{lastname}' => $params['customer']->lastname,
				'{order}' => sprintf('#%06d', (int)$params['order']->id),
				'{document}' => ''
		);

		foreach ($documents as $name => $document)
		{
			if ($document['mail'] != 1 || $document['pdf'] === null)
				continue;

			$file_attachment = array();
			$file_attachment['content'] = base64_decode($document['pdf']);
			$file_attachment['name'] = $name.'.pdf';
			$file_attachment['mime'] = 'application/pdf';

			$template_vars['{document}'] = $name;

			if (Validate::isEmail($params['customer']->email))
				Mail::Send((int)$params['order']->id_lang, 'send_document',
						sprintf(Mail::l('%s', (int)$params['order']->id_lang), $document['document']),
						$template_vars, $params['customer']->email, $params['customer']->firstname.' '.$params['customer']->lastname,
						null, null, $file_attachment, null, dirname(__FILE__).'/mails/', false, (int)$params['order']->id);
		}
	}

	private function getDocumentInfo()
	{
		$result = Tools::jsonDecode($this->request('/v2.0/de/partners/protectedshops/shops/'.Configuration::get('PROTECTEDSHOPS_SHOPID')
				.'/documents/format/json'));

		$documents = array();
		foreach ($result->content->documents as $document)
			$documents[$document->type] = $document->updated_at;

		return $documents;
	}

	private function getDocument($document = 'AGB', $format = null)
	{
		if ($format === null)
			$format = Configuration::get('PROTECTEDSHOPS_FORMAT');

		$result = Tools::jsonDecode($this->request('/v2.0/de/partners/protectedshops/shops/'.Configuration::get('PROTECTEDSHOPS_SHOPID')
				.'/documents/'.$document.'/contentformat/'.$format.'/format/json'));

		$document = array('updated' => (string)$result->updatedAt,'content' => null,'css' => null);
		if (is_object($result->content))
		{
			$document['content'] = (string)$result->content->html;
			$document['css'] = (string)$result->content->css;
		}
		else
			$document['content'] = (string)$result->content;

		return $document;
	}

	private function updateDocuments()
	{
		$request = $this->getDocumentInfo();
		foreach ($request as $document => $date)
		{
			if (!Db::getInstance()->executeS('SELECT * FROM '._DB_PREFIX_."touchdesign_protectedshops_document WHERE document = '".pSQL(trim($document))."'"))
				$sql = 'INSERT INTO '._DB_PREFIX_."touchdesign_protectedshops_document SET
						document = '".pSQL(trim($document))."',
						cms_id = '".pSQL(trim($_POST['PROTECTEDSHOPS_DOCUMENT'][$document]['cms_id']))."',
						mail = '".($_POST['PROTECTEDSHOPS_DOCUMENT'][$document]['mail'] ? 1 : 0)."'";
			else
				$sql = 'UPDATE '._DB_PREFIX_."touchdesign_protectedshops_document SET
						cms_id = '".pSQL(trim($_POST['PROTECTEDSHOPS_DOCUMENT'][$document]['cms_id']))."',
						mail = '".($_POST['PROTECTEDSHOPS_DOCUMENT'][$document]['mail'] ? 1 : 0)."'
						WHERE document = '".pSQL(trim($document))."'";

			if (!Db::getInstance()->Execute($sql))
				return false;
		}

		return true;
	}

	public function refreshDocuments($force = false)
	{
		$documents = $this->getUsedDocuments();
		if (!$documents)
			return false;

		$request = $this->getDocumentInfo();
		foreach ($documents as $name => $document)
		{
			if (!$force && empty($document['failed']) && $document['sync_date'] == $request[$name])
				continue;

			if (!empty($document['cms_id']))
			{
				$document_request = $this->getDocument($name);

				$cms = new CMS($document['cms_id']);
				$cms->content[Configuration::get('PS_LANG_DEFAULT')] = $document_request['content'];
				$cms->update();

				$sql = 'UPDATE '._DB_PREFIX_."touchdesign_protectedshops_document
					SET sync_date = '".pSQL(trim($document_request['updated']))."', refresh_date = NOW(), failed = 0, pdf = null,";

				if ($document_request['css'] === null)
					$sql .= 'css = null';
				else
					$sql .= "css = '".pSQL(trim($document_request['css']))."'";

				$sql .= " WHERE document = '".pSQL(trim($name))."'";

				if (!Db::getInstance()->Execute($sql))
				{
					$sql = 'UPDATE '._DB_PREFIX_."touchdesign_protectedshops_document
						SET failed = failed+1
						WHERE document = '".pSQL(trim($name))."'";
					$this->_errors[] = sprintf($this->l('Failed refresh document %s.'), $name);
					return false;
				}
			}

			if (!empty($document['mail']))
			{
				$document_request = $this->getDocument($name, 'pdf');
				$sql = 'UPDATE '._DB_PREFIX_."touchdesign_protectedshops_document
					SET sync_date = '".pSQL(trim($document_request['updated']))."', refresh_date = NOW(), failed = 0, pdf = '".$document_request['content']."'
					WHERE document = '".pSQL(trim($name))."'";

				if (!Db::getInstance()->Execute($sql))
				{
					$sql = 'UPDATE '._DB_PREFIX_."touchdesign_protectedshops_document
						SET failed = failed+1
						WHERE document = '".pSQL(trim($name))."'";
					$this->_errors[] = sprintf($this->l('Failed refresh pdf document %s.'), $name);
					return false;
				}
			}
		}

		return true;
	}

	private function request($path)
	{
		if (function_exists('curl_exec'))
		{
			$ch = curl_init();
			curl_setopt($ch, CURLOPT_URL, 'https://api.protectedshops.de'.$path);
			curl_setopt($ch, CURLOPT_USERAGENT, 'touchdesign PSmod');
			curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
			curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

			if (($response = curl_exec($ch)) === false)
				return curl_error($ch);
		}
		else
		{
			$socket = fsockopen('ssl://api.protectedshops.de', 443, $errno, $errstr, 5);
			if ($socket)
			{
				fputs($socket, 'GET '.$path." HTTP/1.1\r\n" );
				fputs($socket, "Host: api.protectedshops.de\r\n" );
				fputs($socket, "Content-type: application/x-www-url-encoded\r\n" );
				fputs($socket, "Connection: Close\r\n\r\n" );

				$response = '';
				while (!feof($socket))
					$response .= fgets($socket, 4096);

				fclose($socket);

				$response = Tools::substr($response, strpos($response, "\r\n\r\n") + 8, -5);
			}
		}

		return $response;
	}
}

?>
