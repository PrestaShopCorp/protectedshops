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

<style type="text/css">
fieldset a {
	color:#0099ff;
	text-decoration:underline;
}
fieldset a:hover {
	color:#000000;
	text-decoration:underline;
}
#logo {
	float:right;
	margin-top:-75px;
}
</style>

<div id="logo">
	<img src="../modules/protectedshops/views/img/logo.png" width="356" height="95" alt="logo.png" title="" />
</div>
<div class="clear"></div>

<fieldset class="space">
	<legend><img src="../img/admin/unknown.gif" alt="" class="middle" />{l s='Note' mod='protectedshops'}</legend>
	{l s='For the use of this interface you need a personal ShopKey.' mod='protectedshops'}<br />
	{l s='Get your Shopkey of Protected Shops at:' mod='protectedshops'}
	<a target="_blank" href="http://www.protectedshops.de/?sPartner=Touchdesign">{l s='Request Shopkey' mod='protectedshops'}</a>
</fieldset><br />

<form method="post" action="{$protectedshops.action|escape:'htmlall':'UTF-8'}">
<fieldset>
	<fieldset>
		<legend>{l s='General settings' mod='protectedshops'}</legend>
		<label>{l s='ShopId' mod='protectedshops'}</label>
		<div class="margin-form">
			<input type="text" name="PROTECTEDSHOPS_SHOPID" value="{$protectedshops.config.PROTECTEDSHOPS_SHOPID|escape:'htmlall':'UTF-8'}" />
			<p>{l s='Leave it blank for disabling' mod='protectedshops'}</p>
		</div>
		<div class="clear"></div>    

		<label>{l s='Protected Shops Logo?' mod='protectedshops'}</label>
		<div class="margin-form">
			<select name="PROTECTEDSHOPS_BLOCK_LOGO">
				<option {if $protectedshops.config.PROTECTEDSHOPS_BLOCK_LOGO == "Y"}selected{/if} value="Y">{l s='Yes, display the logo (recommended)' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_BLOCK_LOGO == "N"}selected{/if} value="N">{l s='No, do not display' mod='protectedshops'}</option>
			</select>
			<p>{l s='Display logo in left column' mod='protectedshops'}</p>
		</div>
		<div class="clear"></div>
	</fieldset>
	<br />
	<fieldset>
		<legend>{l s='Document settings' mod='protectedshops'}</legend>
		<label>{l s='Document format' mod='protectedshops'}</label>
		<div class="margin-form">
			<select name="PROTECTEDSHOPS_FORMAT">
				<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html"}selected{/if} value="html">{l s='HTML' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html-lite"}selected{/if} value="html-lite">{l s='HTML-Lite' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "text"}selected{/if} value="text">{l s='Text' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_FORMAT == "html-responsive"}selected{/if} value="html-responsive">{l s='HTML-Responsive' mod='protectedshops'}</option>
			</select>
			<p>{l s='Which format you want to import?' mod='protectedshops'}</p>
		</div>
		<div class="clear"></div>

		<label>{l s='Automatic update' mod='protectedshops'}</label>
		<div class="margin-form">
			<select name="PROTECTEDSHOPS_AUTOMATIC_UPDATE">
				<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "0"}selected{/if} value="0">{l s='disabled' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "6"}selected{/if} value="6">{l s='6 hours' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "12"}selected{/if} value="12">{l s='12 hours' mod='protectedshops'}</option>
				<option {if $protectedshops.config.PROTECTEDSHOPS_AUTOMATIC_UPDATE == "24"}selected{/if} value="24">{l s='24 hours' mod='protectedshops'}</option>
			</select>
			<p>{l s='Automatic update for documents?' mod='protectedshops'}</p>
		</div>
		<div class="clear"></div>
	</fieldset>
	<br />
	<div class="margin-form clear pspace"><input type="submit" name="submitUpdate" value="{l s='Save settings!' mod='protectedshops'}" class="button" /></div>
</fieldset>
</form>
        
{if $protectedshops.config.PROTECTEDSHOPS_SHOPID && $protectedshops.documents.info}

	<form method="post" action="{$protectedshops.action|escape:'htmlall':'UTF-8'}">
	<table class="table" width="100%">
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
	
	<br />
	<div class="margin-form clear pspace"><input type="submit" name="submitDocumentUpdate" value="{l s='Submit settings & refresh documents!' mod='protectedshops'}" class="button" /></div>
	</form><br />

{/if}

<fieldset class="space">
	<legend><img src="../img/admin/unknown.gif" alt="" class="middle" />{l s='Help' mod='protectedshops'}</legend>
	<b>{l s='@Link:' mod='protectedshops'}</b> <a target="_blank" href="http://www.protectedshops.de/?sPartner=Touchdesign">www.protectedshops.de</a><br />
	{l s='@Copyright:' mod='protectedshops'} by <a target="_blank" href="http://www.touchdesign.de/">touchdesign</a><br />
	<b>{l s='@Description:' mod='protectedshops'}</b><br /><br />
	{l s='With the interface to Protected Shops you can automatically retrieve and assign legal texts in your store system. For each platform, you will receive a universal Store Key which you need to retrieve the documents.' mod='protectedshops'}
</fieldset><br />