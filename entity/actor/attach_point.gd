extends Node2D

# Attach point for actors. These determine where their abilities will spawn
class_name AttachPoint

@onready var title_label:Label = $Label
@export var title_text:String = "-1"

func _ready():
	title_label.text = title_text
