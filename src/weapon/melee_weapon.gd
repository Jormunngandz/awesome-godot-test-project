class_name MeleeWeapon extends Node3D

@export var animation_player: AnimationPlayer
@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var hit_area: Area3D

var weapon_data: WeaponData
func _ready() -> void:
	hit_area.body_shape_entered.connect(body_contact)

func body_contact(_body_rid: RID, body: Node3D, body_shape_index: int, _local_shape_index: int) -> void:
	if body.has_method("hit"):
		var collision_part: CollisionShape3D = body.find_children("CollisionShape3D*")[body_shape_index]
		body.hit(self, collision_part)

func attack(new_weapon_data: WeaponData) -> bool:
	weapon_data = new_weapon_data
	animation_player.play("Attack")
	await animation_player.animation_finished
	return true
	
