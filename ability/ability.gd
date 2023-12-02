extends Node2D

class_name Ability

@onready var cooldown_timer = $CooldownTimer
signal ability_action_finished
var cooldown_ready = true
var ability_data:AbilityData
var caster:Actor
var targets:Dictionary
var event_register: Dictionary = {}
var is_running:bool
var is_cast:bool
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
	event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_TIMEOUT] = []
	
func execute(caster_param:Actor, target_dict_param:Dictionary):
	# This is called on ability cast. The caster_param is updated to the current
	# caster, and the target_dict_param is passed a unit and position. These
	# will be used based on the action's targeting enum
	if cooldown_ready:
		cooldown_ready = false
		cooldown_timer.start()
		caster = caster_param
		targets = target_dict_param
		is_running = true
		target_unit = target_dict_param['target_unit']
		target_position = target_dict_param['target_position']
		
		# First we check for ON_ABILITY_START action events. These will be 
		# events that should happen regardless of interruptions, such as mana costs
		# and triggering global cooldowns
		if event_register[DataDrivenAbilitySingleton.event_types.ON_ABILITY_START] != []:
			perform_actions(DataDrivenAbilitySingleton.event_types.ON_ABILITY_START)
		# If it is a channelled spell, perform actions related to movement reduction
		# and locking out other spells
		if channelled:
			pass
		# Otherwise, proceed to events contained in ON_SPELL_START
		else:
			on_spell_start()

func perform_actions(event_type:DataDrivenAbilitySingleton.event_types):
	# Takes an event_type enum. This is used to get the arrry of AbilityEventData 
	var actions = event_register[event_type]
	
	# For every action in this register, execute the action based on its targeting
	for action in actions:
		var execution_iteration_timer:Timer = Timer.new()
		action.execution_iteration_timer = execution_iteration_timer
		add_child(execution_iteration_timer)
		# TODO: Recieve a signal from the actions and call further processing
		if action.data.target_type == DataDrivenAbilitySingleton.target_type.CASTER:
			action.execute_all(self, caster, caster.global_position)
		elif action.data.target_type == DataDrivenAbilitySingleton.target_type.POINT:
			action.execute_all(self, null, target_position)
		elif action.data.target_type == DataDrivenAbilitySingleton.target_type.TARGET:
			action.execute_all(self, target_unit, target_position)
		elif action.data.target_type == DataDrivenAbilitySingleton.target_type.NEAREST_ENEMY:
			if len(target_unit.get_nearby_targets()) > 0:
				action.execute_all(self, target_unit.get_nearby_targets()[0], target_unit.get_nearby_targets()[0].position)

# EVENT REGISTER: ON_SPELL_START
func on_spell_start():
	# Start the cooldown for this ability
	is_cast = true
	# Execute all actions in this event register
	perform_actions(DataDrivenAbilitySingleton.event_types.ON_SPELL_START)

# EVENT REGISTER: ON_PROJECTILE_HIT
func on_projectile_hit(target:Actor):
	print("RUNNING EVENT_REGISTER: ON_PROJECTILE_HIT")
	target_unit = target
	target_position = target.global_position
	if event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT] != []:
		perform_actions(DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_HIT)
	
# EVENT REGISTER: ON_PROJECTILE_TIMEOUT
func on_projectile_timeout(target_pos:Vector2):
	print("RUNNING EVENT_REGISTER: ON_PROJECTILE_TIMEOUT")
	target_position = target_pos
	if event_register[DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_TIMEOUT] != []:
		perform_actions(DataDrivenAbilitySingleton.event_types.ON_PROJECTILE_TIMEOUT)

	


func _on_cooldown_timer_timeout():
	cooldown_ready = true
