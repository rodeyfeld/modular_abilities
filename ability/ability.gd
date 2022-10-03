extends Node2D

class_name Ability

const ON_ABILITY_START:String = "ON_ABILITY_START"
const ON_SPELL_START:String = "ON_SPELL_START"
const ON_CHANNEL_INTERRUPTED:String = "ON_CHANNEL_INTERRUPTED"
const ON_CHANNEL_SUCCEED:String = "ON_CHANNEL_SUCCEED"
const ON_PROJECTILE_HIT_UNIT:String = "ON_PROJECTILE_HIT_UNIT"
const ON_TARGET_DIED:String = "ON_TARGET_DIED"
const ON_UPGRADE:String = "ON_UPGRADE"

var ability_data:AbilityData
var caster:Entity
var targets:Array[Entity]
var event_register:Dictionary = {}
var is_running:bool
var cast_point:Vector2
var target_point:Vector2
var target_unit:Entity

func setup(data:AbilityData):
	ability_data = data
	targets = []
	event_register[ON_ABILITY_START] = []
	
func execute(caster:Entity, target:Array):
	self.caster = caster
	targets = []
	is_running = true
	cast_point = caster.position
	target_point = target[0]
	target_unit = target[1]
	
	if event_register[ON_ABILITY_START] != null:
		print("Okay starting")
	
	
	
