extends Node2D

@onready var player = $PlayerContainer/Player
@onready var enemy_container = $EnemyContainer

func _ready():
	
	for enemy in enemy_container.get_children():
		#add ai controller
		pass
