extends Resource

class_name AbilityActionData

@export var attribute_fields:AttributeDictionary = null
@export var trigger_abilities:Array[DataDrivenAbility] = []
@export var action_type:DataDrivenAbilitySingleton.action_types = DataDrivenAbilitySingleton.action_types.NONE
@export var target:DataDrivenAbilitySingleton.target = DataDrivenAbilitySingleton.target.NONE
@export var to_be_removed:bool
