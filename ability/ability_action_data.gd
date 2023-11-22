extends Resource

class_name AbilityActionData

@export var attribute_fields:AttributeData = null
@export var trigger_abilities:Array[DataDrivenAbility] = []
@export var persistent_abilities:Array[DataDrivenAbility] = []
@export var action_type:DataDrivenAbilitySingleton.action_type = DataDrivenAbilitySingleton.action_type.NONE
@export var target_type:DataDrivenAbilitySingleton.target_type = DataDrivenAbilitySingleton.target_type.NONE
@export var to_be_removed:bool
