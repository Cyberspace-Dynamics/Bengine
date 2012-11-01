<?php if(count($this->getLoop("constructions"))): ?>
<?php $event = $this->get("event") ?>
<?php $umode = Core::getUser()->get("umode") ?>
<table class="ntable">
	<thead><tr><th colspan="3">{lang}RESEARCH{/lang}</th></tr></thead>
	<tbody>
		<?php foreach($this->getLoop("constructions") as $key => $building): ?>
		<?php $id = $building->get("buildingid") ?>
		<?php if(Game::canBuild($id)): ?>
		<?php $required = $building->calculateRequiredResources() ?>
		<tr>
			<td>
				<?php $image = Image::getImage("buildings/".$building->get("name").".gif", $building->getName(), 120, 120) ?>
				<?php echo Link::get("game/".SID."/Constructions/Info/".$id, $image); ?>
			</td>
			<td style="vertical-align: top;">
			<?php echo $building->getLinkName() ?>
			<?php if($building->get("level") > 0): ?>({lang}LEVEL{/lang} <?php echo $building->get("level") ?>)<?php endif ?>
			{perm[CAN_EDIT_CONSTRUCTIONS]}<?php echo $building->getEditLink(); ?>{/perm}<br />
			<?php echo $building->getDescription() ?><br/>
			{lang}REQUIRES{/lang}
			<?php if($required["required_metal"]): ?>
			{lang=METAL}: <?php echo fNumber($required["required_metal"]) ?>
			<?php endif ?>
			<?php if($required["required_silicon"]): ?>
			{lang=SILICON}: <?php echo fNumber($required["required_silicon"]) ?>
			<?php endif ?>
			<?php if($required["required_hydrogen"]): ?>
			{lang=HYDROGEN}: <?php echo fNumber($required["required_hydrogen"]) ?>
			<?php endif ?>
			<?php if($required["required_energy"]): ?>
			{lang=ENERGY}: <?php echo fNumber($required["required_energy"]) ?>
			<?php endif ?>
			<br/>
			{lang}PRODUCTION_TIME{/lang} <?php echo getTimeTerm($building->getProductionTime(false)) ?>
			<?php $isInWork = $event !== false && $event->getData("buildingid") == $id ?>
			<?php if($isInWork): ?>
			<br/>
			{lang=COMPLETED}: <span class="finish-time"><?php echo Date::timeToString(1, $event->get("time")) ?></span>
			<?php endif ?>
		</td>
		<td>
			<?php if(!$umode): ?>
				<?php if($isInWork): ?>
					<?php $timeleft = $event->get("time") - TIME ?>
					<?php $abort = Link::get("game/".SID."/Research/Abort/".$id, Core::getLanguage()->getItem("ABORT")) ?>
					<?php if($event->get("planetid") != Game::getPlanet()->getPlanetId()): ?>
					<?php $abort .= "<br/>(".Core::getLanguage()->get("ON")." ".$event->get("planetname").")" ?>
					<?php endif ?>
					<?php $continue = Link::get("game/".SID."/Research", Core::getLanguage()->getItem("CONTINUE")) ?>
					<span id="bCountDown"><?php echo getTimeTerm($timeleft) ?><br /><?php echo $abort ?></span>
					<script type="text/javascript">
					//<![CDATA[
					var title = $("title");
					var orgTitleText = title.text();
					$('#bCountDown').countdown({until: "<?php echo $timeleft ?>", compact: true, description: '<?php echo $abort ?>', onExpiry: function() {
						title.text("{lang=COMPLETED} - " + orgTitleText);
						$('#bCountDown').html('<?php echo $continue ?>');
					}, onTick: function(period) {
						if(period[0] > 0 || period[1] > 0 || period[2] > 0 || period[3] > 0)
						{
							return true;
						}
						title.text(pad(period[4], 2) + ":" + pad(period[5], 2) + ":" + pad(period[6], 2) + " - " + orgTitleText);
					}});
					//]]>
					</script>
				<?php endif ?>
				<?php if(!$event && $this->get("canResearch")): ?>
					<?php if($building->hasResources()): ?>
						<?php if($building->get("level")): ?>
							<?php echo Link::get("game/".SID."/Research/Upgrade/".$id, Core::getLanguage()->getItem("RESEARCH_OF_LEVEL")." ".($building->get("level")+1), "", "true") ?>
						<?php else: ?>
							<?php echo Link::get("game/".SID."/Research/Upgrade/".$id, Core::getLanguage()->getItem("RESEARCH"), "", "true") ?>
						<?php endif ?>
					<?php else: ?>
						<?php if($building->get("level")): ?>
							<span class="false">{lang=RESEARCH_OF_LEVEL} <?php echo $building->get("level")+1 ?></span>
						<?php else: ?>
							<span class="false">{lang=RESEARCH}</span>
						<?php endif ?>
					<?php endif ?>
				<?php endif ?>
			<?php endif ?>
		</td>
	</tr>
	<?php endif ?>
	<?php endforeach ?>
	</tbody>
</table>
<?php endif ?>