class_name MeleeWeapon extends Node3D

@export var animation_player: AnimationPlayer
@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var hit_area: Area3D
@export var weapon_data: WeaponData
var weapon_owner:CharacterBody3D

func _ready() -> void:
	if get_parent():
		weapon_owner = get_parent().owner
	hit_area.body_shape_entered.connect(body_contact)
	
func body_contact(_body_rid: RID, body: Node3D, body_shape_index: int, _local_shape_index: int) -> void:
	if body == weapon_owner:
		return
	if body.has_method("hit"):
		var collision_part: CollisionShape3D = body.find_children("CollisionShape3D*")[body_shape_index]
		body.hit(self, collision_part)
	if body == Globals.player:
		Globals.player.player_manager.hit(self, null)

func attack(new_weapon_data: WeaponData) -> bool:
	weapon_data = new_weapon_data
	if animation_player:
		animation_player.play("Attack")
		await animation_player.animation_finished
	return true
	
