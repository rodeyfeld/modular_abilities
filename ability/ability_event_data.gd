extends Resource

class_name AbilityEventData

var timer:Timer = Timer.new()

@export var event_type:DataDrivenAbilitySingleton.event_types = DataDrivenAbilitySingleton.event_types.NONE
@export var actions:Array[AbilityActionData] = []
@export var modifiers:Array[AbilityModifierData] = []
@export var repeat_event_num = 0 
@export var time_between_event_repeat = 0
