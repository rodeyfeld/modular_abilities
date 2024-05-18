extends Actor

class_name Player

const basic_spells_class = preload("res://ability/custom_abilities/build_default_spells.gd")


@onready var ability_offensive_attach_point:Marker2D = $AttachPoint/AbilityOffensiveAttachPoint
@onready var player_controller_script = preload("res://controllers/player_controller.gd")
@export var speed = 400
var test_spell = null

func _ready():
	controller.controller_script = player_controller_script.new()
	abilities = {
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
		'6': {
				'scene': preload("res://ability/custom_abilities/flamethrowing_fireball.tres"),
				'ability': null
		},
	}
	title = "player"
	for ability in abilities:
		var data_driven_ability = data_driven_ability_script.new()
		abilities[ability]['ability'] = data_driven_ability.parse(abilities[ability]['scene'])
		add_child(abilities[ability]['ability'])

func _physics_process(delta):
	# Configure deadzone for mouse
	var angle = get_angle_to(get_global_mouse_position())
	var distance = 100
	ability_offensive_attach_point.global_position.x = distance * cos(angle) + self.position.x
	ability_offensive_attach_point.global_position.y = distance * sin(angle) + self.position.y
	get_input()
	controller.controller_script.update(self)
	move_and_slide()


func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed


