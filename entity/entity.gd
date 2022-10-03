extends CharacterBody2D

class_name Entity

var health:int = 10

func update_hp(_amount, _name):
	health += _amount
	pass
