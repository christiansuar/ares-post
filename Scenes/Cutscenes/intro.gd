extends Node3D

@onready var intro_player = $AnimationPlayer

func _ready() -> void:
	intro_player.play("Mission Brief")
