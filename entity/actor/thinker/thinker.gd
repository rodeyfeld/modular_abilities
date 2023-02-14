extends Actor

class_name Thinker

@onready var ability_offensive_attach_point:Marker2D = $AttachPoint/AbilityOffensiveAttachPoint

var fyreball = preload("res://ability/custom_abilities/fyreball.tres")
var ice_nova = preload("res://ability/custom_abilities/ice_nova.tres")
var data_driven_ability_script = load("res://ability/data_driven_ability.gd")

var ability0:Ability
var ability1:Ability


func _ready():
	title = "thinker"
	var data_driven_ability0 = data_driven_ability_script.new()
	ability0 = data_driven_ability0.parse(fyreball)
	add_child(ability0)
	var data_driven_ability1 = data_driven_ability_script.new()
	ability1 = data_driven_ability1.parse(ice_nova)
	add_child(ability1)
		
func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		ability0.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})
	if Input.is_action_just_pressed("test1"):
		ability1.execute(self, {'target_unit':self, 'target_position': get_global_mouse_position()})
	

	# Configure deadzone for mouse
	var angle = self.get_angle_to(get_global_mouse_position())
	var distance = 100
	ability_offensive_attach_point.global_position.x = distance * cos(angle) + self.position.x
	ability_offensive_attach_point.global_position.y = distance * sin(angle) + self.position.y


