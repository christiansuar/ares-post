extends Node3D

@onready var intro_player = $AnimationPlayer


func _ready() -> void:
	intro_player.play("Idle (main menu)")


func _on_button_pressed() -> void:
	intro_player.stop()
	
	intro_player.play("Mission Brief")


func _on_button_2_pressed() -> void:
	get_tree().quit()
