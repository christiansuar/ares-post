extends Node3D

@onready var intro_player = $AnimationPlayer
@onready var tween = create_tween()
@onready var env_exposure = $WorldEnvironment.environment.tonemap_exposure


func _ready() -> void:
	intro_player.play("Idle (main menu)")


func _on_button_pressed() -> void:
	intro_player.stop()
	tween.tween_property($mainmenu, "modulate.a", 0.00, 5.0)
	intro_player.play("Mission Brief")


func _on_button_2_pressed() -> void:
	get_tree().quit()
