extends Actor

class_name Player

@onready var ability_offensive_attach_point:Marker2D = $AttachPoint/AbilityOffensiveAttachPoint

var data_driven_ability_script = load("res://ability/data_driven_ability.gd")

var abilities = {
	'1': {
			'scene': preload("res://ability/custom_abilities/fyreball.tres"),
			'ability': null
	},
	'2': {
			'scene': preload("res://ability/custom_abilities/ice_nova.tres"),
			'ability': null
	},
	'3': {
			'scene': preload("res://ability/custom_abilities/chain_shot.tres"),
			'ability': null
	},
	'4': {
			'scene': preload("res://ability/custom_abilities/spread_shot.tres"),
			'ability': null
	},
}



func _ready():
	title = "player"
	for ability in abilities:
		var data_driven_ability = data_driven_ability_script.new()
		abilities[ability]['ability'] = data_driven_ability.parse(abilities[ability]['scene'])
		add_child(abilities[ability]['ability'])
#	var data_driven_ability0 = data_driven_ability_script.new()
#	ability0 = data_driven_ability0.parse(fyreball)
#	add_child(ability0)
#	var data_driven_ability1 = data_driven_ability_script.new()
#	ability1 = data_driven_ability1.parse(ice_nova)
#	add_child(ability1)
#	var data_driven_ability2 = data_driven_ability_script.new()
#	ability2 = data_driven_ability2.parse(chain_shot)
#	add_child(ability2)
		
func _physics_process(_delta):
	print(abilities)
	for ability in abilities:
		if Input.is_action_just_pressed(ability):
			abilities[ability]['ability'].execute(
				self,
		 		{
					'target_unit':self,
				 	'target_position': get_global_mouse_position()
				}
			)
#	if Input.is_action_just_pressed("test1"):
#		ability1.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})
#	if Input.is_action_just_pressed("test2"):
#		ability2.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})
	

	# Configure deadzone for mouse
	var angle = self.get_angle_to(get_global_mouse_position())
	var distance = 100
	ability_offensive_attach_point.global_position.x = distance * cos(angle) + self.position.x
	ability_offensive_attach_point.global_position.y = distance * sin(angle) + self.position.y
	

		
