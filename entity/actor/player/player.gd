extends Actor

class_name Player

@onready var ability_offensive_attach_point:Marker2D = $AttachPoint/AbilityOffensiveAttachPoint

var fyreball = preload("res://ability/fyreball.tres")
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")
var ability:Ability

func _ready():
	title = "player"
	var data_driven_ability = data_driven_ability_script.new()
	ability = data_driven_ability.parse(fyreball)
	add_child(ability)
		
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		ability.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})

	var angle = self.get_angle_to(get_global_mouse_position())
	var distance = 100
	ability_offensive_attach_point.global_position.x = distance * cos(angle) + self.position.x
	ability_offensive_attach_point.global_position.y = distance * sin(angle) + self.position.y
	
