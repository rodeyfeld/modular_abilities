extends Node2D

class_name Ability

@onready var cooldown_timer = $CooldownTimer

var ability_data:AbilityData
var caster:Actor
var targets:Dictionary
var event_register:Dictionary = {}
var is_running:bool
var is_cast:bool
var cast_point:Vector2
var target_position:Vector2
var target_unit:Actor
var channelled:bool = false:
	get:
		return (ability_data.behavior_flags & DataDrivenAbilitySingleton.behavior_flag.CHANNELLED) != 0
	set(value):
		channelled = value


func setup(data:AbilityData):
	# On setup, set all event registers to blank, they will be filled in by the
	# DataDrivenAbility
	ability_data = data
	# Targeting params for unit vs position coordinates
	targets = {
		'target_unit': null,
		'target_position': null
	}
	event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] = []
	event_register[DataDrivenAbilitySingleton.event_types.ON_SPELL_START] = []
	event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT] = []
	
func execute(caster_param:Actor, target_dict_param:Dictionary):
	# This is called on ability cast. The caster_param is updated to the current
	# caster, and the target_dict_param is passed a unit and position. These
	# will be used based on the action's targeting enum
	caster = caster_param
	targets = target_dict_param
	is_running = true
	cast_point = caster_param.position
	target_unit = target_dict_param['target_unit']
	target_position = target_dict_param['target_position']
	
	# First we check for ON_ABILITY_START action events. These will be 
	# events that should happen regardless of interruptions, such as mana costs
	# and triggering global cooldowns
	if event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] != []:
		print("RUNNING event_types.ON_ABILITY_START")
		perform_actions(event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START])
	# If it is a channelled spell, perform actions related to movement reduction
	# and locking out other spells
	if channelled:
		pass
	# Otherwise, proceed to events contained in ON_SPELL_START
	else:
		on_spell_start()
		
func perform_actions(actions:Array):
	# For every action in this register, execute the action based on its targeting
	for action in actions:
		# TODO: Recieve a signal from the actions and call further processing
		if action.data.target == DataDrivenAbilitySingleton.target.CASTER:
			action.execute(self, caster, target_position)
		elif action.data.target == DataDrivenAbilitySingleton.target.POINT:
			action.execute(self, null, target_position)
		elif action.data.target == DataDrivenAbilitySingleton.target.TARGET:
			action.execute(self, target_unit, target_position)
		elif action.data.target == DataDrivenAbilitySingleton.target.NEAREST_ENEMY:
			action.execute(self, target_unit.get_nearby_targets()[0], target_unit.get_nearby_targets()[0].position)

# EVENT REGISTER: ON_SPELL_START
func on_spell_start():
	# Start the cooldown for this ability
	cooldown_timer.start()
	is_cast = true
	# Execute all actions in this event register
	perform_actions(event_register[DataDrivenAbilitySingleton.event_types.ON_SPELL_START])

# EVENT REGISTER: ON_PROJECTILE_HIT
func on_projectile_hit(target:Actor):
	if event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT] != []:
		for action in event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT]:
			# TODO: Configure targets or pass this to perform_actions()
			action.execute(self, target, target.position)
	
