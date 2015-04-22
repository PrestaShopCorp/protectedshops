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

require dirname(__FILE__).'/../../config/config.inc.php';
require dirname(__FILE__).'/protectedshops.php';

$protectedshops = new Protectedshops();

$lastrun = Configuration::get('PROTECTEDSHOPS_CRON');
$interval = Configuration::get('PROTECTEDSHOPS_AUTOMATIC_UPDATE');

if (!empty($interval) && (($protectedshops->hasFailed() && $lastrun <= strtotime('-1 hour'))
		|| ($lastrun === null || $lastrun <= strtotime('-'.$interval.' hours'))))
{
	if ($protectedshops->refreshDocuments())
		Configuration::updateValue('PROTECTEDSHOPS_CRON', strtotime('now'));

	foreach ($protectedshops->getUsedDocuments() as $name => $document)
	{
		if ($document['failed'] >= 3)
		{
			$template_vars = array('{document}' => $name,
					'{shopid}' => Configuration::get('PROTECTEDSHOPS_SHOPID'));
			if (Validate::isEmail(Configuration::get('PS_SHOP_EMAIL')))
				Mail::Send(Configuration::get('PS_LANG_DEFAULT'), 'failed_document',
						sprintf(Mail::l('Failed update document %s', Configuration::get('PS_LANG_DEFAULT')), $name),
						$template_vars, array(Configuration::get('PS_SHOP_EMAIL'), Configuration::get('PROTECTEDSHOPS_ALERT')),
						Configuration::get('PS_SHOP_EMAIL'), null, null, null, null, dirname(__FILE__).'/mails/', false);
		}
	}
}

header('Content-type: image/png');

if ($im = ImageCreate(1, 1))
{
	ImageColorTransparent($im);
	ImagePNG($im);
}

?>