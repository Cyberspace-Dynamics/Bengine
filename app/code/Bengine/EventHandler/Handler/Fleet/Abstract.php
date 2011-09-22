<?php
/**
 * Abstract handler for fleet events.
 *
 * @package Bengine
 * @copyright Copyright protected by / Urheberrechtlich geschützt durch "Sebastian Noll" <snoll@4ym.org>
 * @version $Id: Abstract.php 8 2010-10-17 20:55:04Z secretchampion $
 */

abstract class Bengine_EventHandler_Handler_Fleet_Abstract extends Bengine_EventHandler_Handler_Abstract
{
	/**
	 * Contains the relation object.
	 *
	 * @var Bengine_User_Relation
	 */
	protected $_relations = null;

	/**
	 * Contains the target data.
	 *
	 * @var array
	 */
	protected $_target = array();

	/**
	 * Contains the target type.
	 *
	 * @var string
	 */
	protected $_targetType = "planet";

	/**
	 * Contains all ships.
	 *
	 * @var array
	 */
	protected $_ships = array();

	/**
	 * Contains the logic for each event validation.
	 *
	 * @return boolean
	 */
	protected abstract function _isValid();

	/**
	 * Checks the fleet event for validation.
	 *
	 * @return boolean
	 */
	public function isValid()
	{
		if($this->isSamePosition())
		{
			return false;
		}
		return $this->_isValid();
	}

	/**
	 * Checks, if both original planet and target planet have the same position.
	 *
	 * @return boolean
	 */
	public function isSamePosition()
	{
		if(isset($this->_target["planetid"]) && $this->_target["planetid"] == Core::getUser()->get("curplanet") && $this->_targetType != "tf")
		{
			return true;
		}
		return false;
	}

	/**
	 * Sets the relation object.
	 *
	 * @param Bengine_User_Relation	Relation object
	 *
	 * @return Bengine_EventHandler_Handler_Fleet_Abstract
	 */
	public function setRelations(Bengine_User_Relation $relations)
	{
		$this->_relations = $relations;
		return $this;
	}

	/**
	 * Setst the target data.
	 *
	 * @param array		Data
	 *
	 * @return Bengine_EventHandler_Handler_Fleet_Abstract
	 */
	public function setTarget(array $target = null)
	{
		if(!empty($target))
			$this->_target = $target;
		return $this;
	}

	/**
	 * Sets the target type.
	 *
	 * @param string	Target type
	 *
	 * @return Bengine_EventHandler_Handler_Fleet_Abstract
	 */
	public function setTargetType($targetType)
	{
		$this->_targetType = $targetType;
		return $this;
	}

	/**
	 * Sets the ships.
	 *
	 * @param array		Ships
	 *
	 * @return Bengine_EventHandler_Handler_Fleet_Abstract
	 */
	public function setShips(array $ships)
	{
		$this->_ships = $ships;
		return $this;
	}

	/**
	 * Checks if the target is newbie protected.
	 *
	 * @return boolean
	 */
	public function isNewbieProtected()
	{
		$ignoreNP = false;
		$newbieprotected = false;
		if($this->_target["last"] <= TIME - 604800)
		{
			$ignoreNP = true;
		}
		else if($this->_target["to"] >= TIME)
		{
			$ignoreNP = true;
		}

		if(!$ignoreNP)
		{
			$newbieprotected = isNewbieProtected(Core::getUser()->get("points"), $this->_target["points"]);
		}
		return $newbieprotected;
	}

	/**
	 * This is a workaround for retrieving formation data.
	 *
	 * @return boolean
	 */
	public function getSpecialData()
	{
		return false;
	}
}