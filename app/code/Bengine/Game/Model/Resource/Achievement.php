<?php
/**
 * Achievement resource model.
 *
 * @package Bengine
 * @copyright Copyright protected by / Urheberrechtlich geschützt durch "Sebastian Noll" <snoll@4ym.org>
 */

class Bengine_Game_Model_Resource_Achievement extends Recipe_Model_Resource_Abstract
{
	protected function init()
	{
		$this->setMainTable(array("a" => "achievement"));
		return parent::init();
	}

	/**
	 * @return Recipe_Database_Select
	 */
	public function getSelect()
	{
		$select = parent::getSelect();
		$this->addL10nOverlay($select, array(
			"name", "description"
		));
		return $select;
	}
}
?>