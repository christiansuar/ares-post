extends Node3D

@onready var intro_player = $AnimationPlayer
@onready var spam_prev = true
@onready var env_exposure = $WorldEnvironment.environment
@onready var cam = $AnimationPlayer/Camera3D


func _ready() -> void:
	intro_player.play("Idle (main menu)")

func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	if spam_prev:
		#PREVENTS SPAMMING THE BUTTON
		spam_prev = false
		
		var targetRotation = -deg_to_rad(cam.rotation_degrees.y) + .5
		print(targetRotation)
		
		
		var tween1 = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		var tween3 = get_tree().create_tween()
		var tween4 = get_tree().create_tween()
		
		tween1.tween_property(env_exposure, "tonemap_exposure", 0.0, 5.0)
		tween2.tween_property($mainmenu, "modulate:a", 0.0, 5.0)
		tween3.tween_property($AnimationPlayer/SpaceShip, "position:z", -100, 5.0)

		tween4.tween_property(cam, "rotation:y" , targetRotation, 1.0 ).as_relative().set_ease(Tween.EASE_IN_OUT)

		
		await tween1.finished
	
		await get_tree().create_timer(.5).timeout
		cam.rotation_degrees.y = 118
		intro_player.play("Mission Brief")
		print(cam.rotation.y)
