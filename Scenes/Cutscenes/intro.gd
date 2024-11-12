extends Node3D

@onready var intro_player = $AnimationPlayer
@onready var spam_prev = true
@onready var env_exposure = $WorldEnvironment.environment


func _ready() -> void:
	intro_player.play("Idle (main menu)")


func _on_button_pressed() -> void:
	if spam_prev:
		#PREVENTS SPAMMING THE BUTTON
		spam_prev = false
		
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		
		tween1.tween_property(env_exposure, "tonemap_exposure", 0.0, 5.0)
		tween2.tween_property($mainmenu, "modulate:a", 0.0, 5.0)
		
		await tween1.finished
		
		
		intro_player.play("Mission Brief")


func _on_button_2_pressed() -> void:
	get_tree().quit()
