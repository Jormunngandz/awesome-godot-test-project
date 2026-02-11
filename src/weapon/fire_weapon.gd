class_name FireWeapon extends Node3D

@export var muzzle: Marker3D #start_position of projectile
@export var audio_player: AudioStreamPlayer3D
@export var weapon_data: WeaponData
@export var projectile_model: PackedScene # scene of projectile to instanciate

var weapon_stats:WeaponData

func _ready() -> void:
	weapon_stats = weapon_data.duplicate()

func refill(value):
	weapon_stats.current_ammo = min(weapon_stats.max_ammo, weapon_stats.current_ammo + value)
	fire()
func fire() -> void:
	var projectile = projectile_model.instantiate()

	projectile.position = muzzle.global_position
	projectile.transform.basis = muzzle.global_transform.basis
	get_tree().root.add_child(projectile)
	audio_player.play()
