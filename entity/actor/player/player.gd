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
	'5': {
			'scene': preload("res://ability/custom_abilities/plasma_beam.tres"),
			'ability': null
	},
}



func _ready():
	title = "player"
	for ability in abilities:
		var data_driven_ability = data_driven_ability_script.new()
		abilities[ability]['ability'] = data_driven_ability.parse(abilities[ability]['scene'])
		add_child(abilities[ability]['ability'])

		
func _physics_process(_delta):
	for ability in abilities:
		if Input.is_action_just_pressed(ability):
			abilities[ability]['ability'].execute(
				self,
		 		{
					'target_unit':self,
				 	'target_position': get_global_mouse_position()
				}
			)

	# Configure deadzone for mouse
	var angle = self.get_angle_to(get_global_mouse_position())
	var distance = 100
	ability_offensive_attach_point.global_position.x = distance * cos(angle) + self.position.x
	ability_offensive_attach_point.global_position.y = distance * sin(angle) + self.position.y
	

		
