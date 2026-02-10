extends Node3D



var bullet = preload("res://assets/weapon/skull_gun/skull_gun_projectile/skull_gun_projectile.tscn")
@export var marker_3d_muzzle: Marker3D 
@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var base_weapon_stats: BaseWeapon


var projectile 
var weapon_stats:BaseWeapon

func initialize():
	pass
func _ready() -> void:
	weapon_stats = base_weapon_stats.duplicate()

func refill(value):
	weapon_stats.current_ammo = min(weapon_stats.max_ammo, weapon_stats.current_ammo + value)
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("Attack"):
		
		projectile = bullet.instantiate()

		projectile.position = marker_3d_muzzle.global_position
		projectile.transform.basis = marker_3d_muzzle.global_transform.basis
		get_tree().root.add_child(projectile)
		audio_stream_player_3d.play()
		#print("вызываю череп")
		
