class_name Projectile extends Node3D
@export var audio_player: AudioStreamPlayer3D
@export var projectile_model: ArrayMesh
@export var shape: CollisionShape3D
@export var contact_area: Area3D
@export var on_hit_particles: GPUParticles3D
@export var animation_player: AnimationPlayer #Player must have "Hit" animation
@export var projectile_data: ProjectileData
@onready var projectile_stats:ProjectileData = projectile_data.duplicate()
var ttl_timer:Timer


func _ready() -> void:
	set_ttl_timer()
	set_signals()
	
	
func _physics_process(delta):
	position += transform.basis * Vector3(0,projectile_stats.speed,0) * delta


func set_ttl_timer():
	ttl_timer = Timer.new()
	add_child(ttl_timer)
	ttl_timer.start(projectile_data.TTL)
	ttl_timer.timeout.connect(queue_free)
	
	
func set_signals():
	contact_area.body_shape_entered.connect(body_contact)
	contact_area.area_entered.connect(area_contact)
	

func contact(hitted_obj: Node3D):
	#print(self, ": ", "hitted ", hitted_obj)
	#set_physics_process(false)
	contact_area.queue_free()
	set_player_sound(hitted_obj)
	if animation_player.has_animation("Hit"):
		ttl_timer.stop()
		animation_player.play("Hit")
		await  animation_player.animation_finished
	else:
		queue_free()
		

func body_contact(_body_rid: RID, body: Node3D, body_shape_index: int, _local_shape_index: int) -> void:
	#print("body_contact with: ", body)
	contact(body)
	
	if body.has_method("hit"):
		
		var collision_part: CollisionShape3D = body.find_children("CollisionShape3D*")[body_shape_index]
		body.hit(self, collision_part)
	if body.owner.has_method("proccess_destruction"):
		body.owner.proccess_destruction(contact_area)
		
		
func area_contact(area: Area3D) -> void:
	#print("area_contact with: ", area.get_parent())
	#print(area.get_parent())
	contact(area)
	var parent_obj = area.owner
	if parent_obj.has_method("hit"):
		parent_obj.hit(self, area)
	if parent_obj.has_method("proccess_destruction"):
		parent_obj.proccess_destruction(contact_area)


func set_player_sound(obj: Node3D):
	if obj.is_in_group("metal_object"):
		audio_player.stream = projectile_stats.metal_hit
	elif obj.is_in_group("wood_object"):
		audio_player.stream = projectile_stats.wood_hit
	elif obj.is_in_group("Enemy"):
		audio_player.stream = projectile_stats.body_hit
	else:
		audio_player.stream = projectile_stats.base_hit_sound
	audio_player.play()



#func _on_area_3d_body_entered(body: Node3D) -> void:
	#hit(body)
	#if body.has_method("hit"):
		#body.hit(self, body)
	
	
	
