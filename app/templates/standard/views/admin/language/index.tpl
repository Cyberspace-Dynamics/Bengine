<h1>{lang}Language_Manager{/lang}</h1>
<div class="draggable">
	<form method="post">
		<table class="ntable" cellpadding="4" cellspacing="0">
			<thead>
				<tr>
					<th colspan="2">{lang}Add_New_Phrase{/lang}</th>
				</tr>
			</thead>
			<tr>
				<td><label for="f_language">{lang}Language{/lang}</label></td>
				<td><select name="languageid" id="f_language">{foreach[langselection]}<option value="{loop}languageid{/loop}">{loop}title{/loop}</option>{/foreach}</select></td>
			</tr>
			<tr>
				<td><label for="f_phrasegroup">{lang}Phrase_Group{/lang}</label></td>
				<td><select name="phrasegroupid" id="f_phrasegroup">{foreach[groupselection]}<option value="{loop}phrasegroupid{/loop}">{loop}title{/loop}</option>{/foreach}</select></td>
			</tr>
			<tr>
				<td><label for="f_title">{lang}Phrase_Name{/lang}</label></td>
				<td><input type="text" name="title" maxlength="128" id="f_title" /></td>
			</tr>
			<tr>
				<td><label for="f_content">{lang}Phrase_Content{/lang}</label></td>
				<td><textarea cols="50" rows="5" name="content" id="f_content"></textarea></td>
			</tr>
			<tfoot>
				<tr>
					<td colspan="2" style="text-align: center;"><input type="submit" name="add_phrase" value="{lang}Commit{/lang}" class="button" /></td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div class="draggable">
	<form method="post" action="{@faction}">
		<input type="hidden" name="delete[]" value="0"/>
		<table class="ntable" cellpadding="4" cellspacing="0">
			<thead>
				<tr>
					<th colspan="4">{lang}Manager_Languages{/lang}</th>
				</tr>
			</thead>
			<tr>
				<td>{lang}Language{/lang}</td>
				<td>{lang}Charset{/lang}</td>
				<td>{lang}Variables{/lang}</td>
				<td>{lang}Delete{/lang}</td>
			</tr>
			{foreach[languages]}<tr>
				<td>[{loop}langcode{/loop}] <input type="hidden" name="langs[]" value="{loop}languageid{/loop}" /><input type="text" name="title_{loop}languageid{/loop}" value="{loop}title{/loop}" maxlength="128" /></td>
				<td><input type="text" name="charset_{loop}languageid{/loop}" value="{loop}charset{/loop}" maxlength="128" /></td>
				<td>{loop}phrases{/loop}</td>
				<td><input type="checkbox" name="delete[]" value="{loop}languageid{/loop}" /></td> {loop}link{/loop}
			</tr>{/foreach}
			<tfoot>
				<tr>
					<td colspan="4">
						<input type="submit" name="save_languages" value="{lang}Commit{/lang}" class="button" /><br />
						[{link[New_Language]}"admin/language/newlanguage"{/link}]
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<div id="right">
	<div class="link_b">
		{link[Phrases_Groups]}"admin/language/phrasesgroups"{/link}<br/>
		{link[Import_Export]}"admin/language/porting"{/link}
	</div>
</div>