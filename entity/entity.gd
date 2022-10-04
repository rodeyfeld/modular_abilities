extends CharacterBody2D

class_name Entity

var health:int = 10

func _ready():
	print("STARTED")

func update_hp(_amount, _name):
	health += _amount
	pass
