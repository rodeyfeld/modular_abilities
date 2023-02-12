extends Node

enum event_types {
	NONE,
	ON_SPELL_START,
	ON_ABILITY_START,
	ON_PROJECTILE_HIT,
}

enum action_types {
	NONE,
	DAMAGE,
	HEAL,
	LINEAR_PROJECTILE,
	AUXILIARY,
}

enum target_flag {
		NONE = 1 << 0,
		SELF = 1 << 1,
		ENEMY = 1 << 2,
}

enum target {
		NONE,
		CASTER,
		TARGET,
		POINT,
		NEAREST_ENEMY,
}

# https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools/Scripting/Abilities_Data_Driven
enum behavior_flag {
		TEST = 1 << 0, # Test value
		PASSIVE = 1 << 1, #Cannot be cast like above but this one shows up on the ability HUD.
		NO_TARGET = 1 << 2, #Doesn't need a target to be cast, ability fires off as soon as the button is pressed.
		UNIT_TARGET = 1 << 3, #Needs a target to be cast on.
		POINT_TARGET = 1 << 4, #Can be cast anywhere the mouse cursor is (if a unit is clicked it will just be cast where the unit was standing).
		AOE = 1 << 5, #Draws a radius where the ability will have effect. Kinda like POINT but with a an area of effect display.
		CHANNELLED = 1 << 6, #Channeled ability. If the user moves or is silenced the ability is interrupted.
		ITEM = 1 << 7, #Ability is tied up to an item.
		DIRECTIONAL = 1 << 8, #Has a direction from the hero, such as miranas arrow or pudge's hook.
		IMMEDIATE = 1 << 9, #Can be used instantly without going into the action queue.
		AUTOCAST = 1 << 10, #Can be cast automatically.
		AURA = 1 << 11, #Ability is an aura.  Not really used other than to tag the ability as such.
		ROOT_DISABLES = 1 << 12, #Cannot be used when rooted
		DONT_CANCEL_MOVEMENT = 1 << 13, #Doesn't cause certain modifiers to end, used for courier and speed burst.
}

# TODO: Refactor this to point to class names or a more complex mapping table
var action_type_map = {
	action_types.DAMAGE: "res://ability/action/damage.gd",
	action_types.LINEAR_PROJECTILE: "res://ability/action/linear_projectile.gd",
	action_types.AUXILIARY: "res://ability/action/auxiliary.gd",
	action_types.HEAL: "res://ability/action/heal.gd",
	
}
