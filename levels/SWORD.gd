extends Node3D

@export var damage = 1.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $SWORD/AudioStreamPlayer3D

var can_slah=false
var enemies_in_range = []

func _physics_process(delta: float) -> void:
	print("меч")
	if Input.is_action_just_pressed("Attack"):
		animation_player.play("Hit")
		audio_stream_player_3d.play()
		print("меч")

func _on_area_3d_body_entered(body: Node3D) -> void:
	pass # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	pass # Replace with function body.
