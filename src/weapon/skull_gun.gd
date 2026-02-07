extends Node3D



var bullet = preload("res://assets/weapon/skull_gun/skull_gun_projectile/skull_gun_projectile.tscn")
@onready var marker_3d_muzzle: Marker3D = $Marker3D_muzzle
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D



var Skull_instance 


func initialize():
	pass
func _ready() -> void:
	pass
	
func _physics_process(delta):
	if Input.is_action_just_pressed("Attack"):
		
		Skull_instance = bullet.instantiate()

		Skull_instance.position = marker_3d_muzzle.global_position
		Skull_instance.transform.basis = marker_3d_muzzle.global_transform.basis
		get_tree().root.add_child(Skull_instance)
		audio_stream_player_3d.play()
		print("вызываю череп")
		
