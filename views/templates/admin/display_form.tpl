{**
 *
 * protectedshops Module
 *
 * Copyright (c) 2011 touchdesign
 *
 * @category  Tools
 * @copyright 02.02.2011, touchdesign
 * @author    Christin Gruber, <www.touchdesign.de>
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
 *}

{literal}
<style type="text/css">
.touchdesign.container {margin-left:0 !important;}
.touchdesign {margin-top:20px;}
.touchdesign .margin-bottom {margin-bottom:20px;}
.touchdesign .bordered {border:1px solid #ccc;}
.touchdesign .partner {float:left}
.touchdesign .list-checklist {margin-left:-10px;list-style-type:none;}
.touchdesign .list-checklist li {margin-bottom:0.5em;min-height:30px}
.touchdesign .list-checklist li:before {position:absolute;left:0;content:url(../modules/protectedshops/views/img/icons/ok.png) " "}
</style>
{/literal}

<div class="touchdesign container margin-top">

<div class="row margin-bottom">
	<div class="col-sm-3"><img src="../modules/protectedshops/views/img/logo.png" class="img-responsive" alt="logo.png" title="" /></div>
	<div class="col-sm-6">
		<p><img class="partner" src="../modules/protectedshops/views/img/{$protectedshops.mod_lang|escape:'htmlall':'UTF-8'}/partner.png" alt="partner.png" title="" /> {l s='As an official Partner of PrestaShop, Protected Shops offers the possibility to sell online legally safe within 15 minutes.' mod='protectedshops'} <b>{l s='The service contains the responsibility for legal texts and automatic update when new laws or court decisions become effective.' mod='protectedshops'}</b></p>
	</div>
	<div class="col-sm-3">
		<a target="_blank" href="http://www.protectedshops.de/partner/prestashop?sPartner=prestamodule">
			<img src="../modules/protectedshops/views/img/{$protectedshops.mod_lang|escape:'htmlall':'UTF-8'}/button.png" class="img-responsive" alt="button.png" title="" />
		</a>
	</div>
</div>

<div class="row margin-bottom">
	<div class="col-sm-3">
		<h2><img class="inline" src="../modules/protectedshops/views/img/icons/protectpacket.png" alt="protectpacket.png" title="" /> {l s='Individual legal texts' mod='protectedshops'}</h2>
		<p>{l s='Terms and conditions, cancellation policy, privacy policy, imprint, payment and delivery terms created through questionnaired creation.' mod='protectedshops'}</p>
	</div>
	<div class="col-sm-3">
		<h2><img class="inline" src="../modules/protectedshops/views/img/icons/assumption-of-liability.png" alt="assumption-of-liability.png" title="" /> {l s='Responsibility for legal texts' mod='protectedshops'}</h2>
		<p>{l s='Protected Shops is responsible for all their generated legal texts - be safe against legal proceedings and costs.' mod='protectedshops'}</p>
	</div>
	<div class="col-sm-3">
		<h2><img class="inline" src="../modules/protectedshops/views/img/icons/update.png" alt="update.png" title="" /> {l s='Update Flatrate' mod='protectedshops'}</h2>
		<p>{l s='Prompt update of the legal texts when new legal requirements appear. Automatically by plugin, otherwise per notification.' mod='protectedshops'}</p>
	</div>
	<div class="col-sm-3">
		<h2><img class="inline" src="../modules/protectedshops/views/img/icons/umbrella.png" alt="umbrella.png" title="" /> {l s='Safe in 15 minutes' mod='protectedshops'}</h2>
		<p>{l s='Questionnaire for individual business models and situations creates DIRECT legally safe terms and conditions, cancellation policy, imprint etc.' mod='protectedshops'}</p>
	</div>
</div>

<div class="row margin-bottom bordered">
	<div class="col-sm-3">
		<a target="_blank" href="http://www.protectedshops.de/partner/prestashop?sPartner=prestamodule">
			<img src="../modules/protectedshops/views/img/{$protectedshops.mod_lang|escape:'htmlall':'UTF-8'}/specialoffer.png" class="img-responsive" alt="specialoffer.png" title="" />
		</a>
	</div>
	<div class="col-sm-9">
		<h2>{l s='This is how simple the legal protection works:' mod='protectedshops'}</h2>
		<div class="col-sm-4">
			<ul class="list-checklist">
				<li>{l s='Choose your safety package on www.protectedshops.de.' mod='protectedshops'}</li>
				<li>{l s='Go through the questionnaire.' mod='protectedshops'}</li>
				<li>{l s='Under the menu \'Schnittstellen\' select the field \'Uebersicht Shop-IDs\'.' mod='protectedshops'}</li>
				<li>{l s='Copy your ShopID.' mod='protectedshops'}</li>
			</ul>
		</div>
		<div class="col-sm-4">
			<ul class="list-checklist">
				<li>{l s='Within this PrestaShop Modul configuration site go to the section \'general settings->ShopID\'.' mod='protectedshops'}</li>
				<li>{l s='Then insert ShopID, adjust \'format and frequency of the updating\' and \'save settings\'.' mod='protectedshops'}</li>
				<li>{l s='Refer and save \'documents and target sites\'.' mod='protectedshops'}</li>
		</div>
		<div class="col-sm-4">
			<ul class="list-checklist">
				<li>{l s='Be safe against legal proceedings within a few minutes!' mod='protectedshops'}</li>
			</ul>
			<img src="../modules/protectedshops/views/img/feature.png" class="img-responsive" alt="feature.png" title="" />
		</div>
	</div>
</div>

<div class="row">
	<div class="col-sm-3">
		<form method="post" class="form-horizontal" role="form" action="{$protectedshops.action|escape:'htmlall':'UTF-8'}">
		<div class="panel">
			<div class="panel-heading">
				<i class="icon-cogs"></i> {l s='General settings' mod='protectedshops'}
			</div>
			<div class="form-group">
				<label for="PROTECTEDSHOPS_SHOPID">{l s='ShopId' mod='protectedshops'}</label>
				<input id="PROTECTEDSHOPS_SHOPID" class="form-control" aria-describedby="helpPROTECTEDSHOPS_SHOPID" type="text" name="PROTECTEDSHOPS_SHOPID" value="{$protectedshops.config.PROTECTEDSHOPS_SHOPID|escape:'htmlall':'UTF-8'}" />
				<span id="helpPROTECTEDSHOPS_SHOPID" class="help-block">{l s='Leave it blank for disabling' mod='protectedshops'}</span>
			</div>
			<div class="form-group">
				<label for="PROTECTEDSHOPS_BLOCK_LOGO">{l s='Protected Shops Logo?' mod='protectedshops'}</label>
				<select id="PROTECTEDSHOPS_BLOCK_LOGO" name="PROTECTEDSHOPS_BLOCK_LOGO" class="form-control" aria-describedby="helpPROTECTEDSHOPS_BLOCK_LOGO">
					<option {if $protectedshops.config.PROTECTEDSHOPS_BLOCK_LOGO == "Y"}selected{/if} value="Y">{l s='Yes, display the logo (recommended)' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_BLOCK_LOGO == "N"}selected{/if} value="N">{l s='No, do not display' mod='protectedshops'}</option>
				</select>
				<span id="helpPROTECTEDSHOPS_BLOCK_LOGO" class="help-block">{l s='Display logo in left column' mod='protectedshops'}</span>
			</div>
			<div class="form-group">
				<label for="PROTECTEDSHOPS_FORMAT">{l s='Document format' mod='protectedshops'}</label>
				<select id="PROTECTEDSHOPS_FORMAT" name="PROTECTEDSHOPS_FORMAT" class="form-control" aria-describedby="helpPROTECTEDSHOPS_FORMAT">
					<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html"}selected{/if} value="html">{l s='HTML' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html-lite"}selected{/if} value="html-lite">{l s='HTML-Lite' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "text"}selected{/if} value="text">{l s='Text' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html-responsive"}selected{/if} value="html-responsive">{l s='HTML-Responsive' mod='protectedshops'}</option>
				</select>
				<span id="helpPROTECTEDSHOPS_FORMAT" class="help-block">{l s='Which format you want to import?' mod='protectedshops'}</span>
			</div>
			<div class="form-group">
				<label for="PROTECTEDSHOPS_AUTOMATIC_UPDATE">{l s='Automatic update' mod='protectedshops'}</label>
				<select id="PROTECTEDSHOPS_AUTOMATIC_UPDATE" name="PROTECTEDSHOPS_AUTOMATIC_UPDATE" class="form-control" aria-describedby="helpPROTECTEDSHOPS_AUTOMATIC_UPDATE">
					<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "0"}selected{/if} value="0">{l s='disabled' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "6"}selected{/if} value="6">{l s='6 hours' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "12"}selected{/if} value="12">{l s='12 hours' mod='protectedshops'}</option>
					<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "24"}selected{/if} value="24">{l s='24 hours' mod='protectedshops'}</option>
				</select>
				<span id="helpPROTECTEDSHOPS_AUTOMATIC_UPDATE" class="help-block">{l s='Automatic update for documents?' mod='protectedshops'}</span>
			</div>
			<input type="submit" name="submitUpdate" value="{l s='Save settings!' mod='protectedshops'}" class="btn btn-default" />
		</div>
		</form>
	</div>
	<div class="col-sm-9">
		{if $protectedshops.config.PROTECTEDSHOPS_SHOPID && $protectedshops.documents.info}
		<div class="panel">
			<div class="panel-heading">
				<i class="icon-cogs"></i> {l s='Document settings' mod='protectedshops'}
			</div>
			<div class="table-responsive table-condensed">
				<form method="post" action="{$protectedshops.action|escape:'htmlall':'UTF-8'}">
					<table class="table table_grid">
					<tr>
						<th>{l s='Document' mod='protectedshops'}</th>
						<th>{l s='Target' mod='protectedshops'}</th>
						<th>{l s='Send mail' mod='protectedshops'}</th>
						<th>{l s='Last sync date' mod='protectedshops'}</th>
						<th>{l s='Is fresh' mod='protectedshops'}</td>
					</tr>
					{foreach key=name item=date from=$protectedshops.documents.info}
					<tr>
						<td>{$name|escape:'htmlall':'UTF-8'}</td>
						<td>
							<select name="PROTECTEDSHOPS_DOCUMENT[{$name|escape:'htmlall':'UTF-8'}][cms_id]">
							{foreach key=id item=page from=$protectedshops.documents.cms_items}
								<option value="{$id|escape:'htmlall':'UTF-8'}" {if isset($protectedshops.documents.used[$name]['sync_date']) && $protectedshops.documents.used[$name]['cms_id'] == $id}selected="selected"{/if}>{$page|escape:'htmlall':'UTF-8'}</option>
							{/foreach}
							</select>
						</td>
						<td>
							<select name="PROTECTEDSHOPS_DOCUMENT[{$name|escape:'htmlall':'UTF-8'}][mail]">
								<option {if isset($protectedshops.documents.used[$name]['mail']) && $protectedshops.documents.used[$name]['mail'] == 0}selected{/if} value=0>{l s='No' mod='protectedshops'}</option>
								<option {if isset($protectedshops.documents.used[$name]['mail']) && $protectedshops.documents.used[$name]['mail'] == 1}selected{/if} value=1>{l s='Yes' mod='protectedshops'}</option>
							</select>
						</td>
						<td>{if isset($protectedshops.documents.used[$name]['refresh_date'])}{$protectedshops.documents.used[$name]['refresh_date']|escape:'htmlall':'UTF-8'}{else}{l s='never' mod='protectedshops'}{/if}</td>
						<td>{if isset($protectedshops.documents.used[$name]['sync_date']) && $protectedshops.documents.used[$name]['sync_date'] == $date}{l s='Yes' mod='protectedshops'}{else}{l s='No' mod='protectedshops'}{/if}</td>
					</tr>
					{/foreach}
					</table>
					<input type="submit" name="submitDocumentUpdate" value="{l s='Submit settings & refresh documents!' mod='protectedshops'}" class="btn btn-default" />
				</form>
			</div>
		</div>
		{/if}
	</div>
</div>
<div class="row">
	<div class="panel">
		<div class="panel-heading">
			<i class="icon-support"></i> {l s='Help' mod='protectedshops'}
		</div>
		<b>{l s='@Link:' mod='protectedshops'}</b> <a target="_blank" href="http://www.protectedshops.de/partner/prestashop?sPartner=prestamodule">www.protectedshops.de</a><br />
		{l s='@Copyright:' mod='protectedshops'} by <a target="_blank" href="http://www.touchdesign.de/">touchdesign</a><br />
		<b>{l s='@Description:' mod='protectedshops'}</b><br /><br />
		{l s='With the interface to Protected Shops you can automatically retrieve and assign legal texts in your store system. For each platform, you will receive a universal Store Key which you need to retrieve the documents.' mod='protectedshops'}
	</div>
</div>

</div>