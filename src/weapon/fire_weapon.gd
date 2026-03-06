class_name FireWeapon extends Node3D

@export var muzzle: Marker3D #start_position of projectile
@export var audio_player: AudioStreamPlayer3D
@export var projectile_model: PackedScene # scene of projectile to instanciate


func fire(_weapon_data: WeaponData) -> void:
	var projectile = projectile_model.instantiate()

	projectile.position = muzzle.global_position
	projectile.transform.basis = muzzle.global_transform.basis
	get_tree().root.add_child(projectile)
	audio_player.play()
