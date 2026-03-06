class_name BaseEnemyLogic extends CharacterBody3D

@export var navigation_agent: NavigationAgent3D
@export var npc_stats: base_npc
@export var attack_raycast: RayCast3D
@onready var stats: base_npc
@export var head_area: Area3D
@export var body_collision: CollisionShape3D
@export var weapon_area: Area3D


func _ready() -> void:
	if head_area:
		head_area.set_meta("dmg_mul", npc_stats.head_shot_multi)
	body_collision.set_meta("dmg_mul", npc_stats.base_dmg_multi) 
	stats = npc_stats.duplicate()
	navigation_agent.max_speed = stats.max_speed
	
	
func _physics_process(delta: float) -> void:
	walk_to_target(delta)

func do_damage_body(_body_rid: RID, body: Node3D, body_shape_index: int, _local_shape_index: int) -> void:
	pass
	
func do_damage_area(area: Area3D) -> void:
	pass

func walk_to_target(delta: float):
	navigation_agent.set_target_position(Globals.player.global_position)
			
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()
	var look_at_pos = Vector3(next_path_position.x, global_position.y, next_path_position.z)
	if not global_position.is_equal_approx(look_at_pos):
		look_at(look_at_pos,Vector3.UP)
	velocity = global_position.direction_to(next_path_position) * Vector3(stats.speed,0,stats.speed)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


func hit(source, damaged_part: Node3D):
	var multi_dmg: float = damaged_part.get_meta("dmg_mul", 1.0)
	if is_instance_of(source, Projectile):
		stats.hp -= source.projectile_data.damage * multi_dmg
	elif is_instance_of(source, MeleeWeapon):
		print("source ", source)
		print("damaged_part ", damaged_part)
		print("owner ", damaged_part.owner)
		stats.hp -= source.weapon_data.base_damage * multi_dmg
	if stats.hp <= 0:
		dead()
		
	
func dead():
	var despawn_timer = Timer.new()
	add_child(despawn_timer)
	despawn_timer.start(3)
	await despawn_timer.timeout
	queue_free()
