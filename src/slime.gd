extends CharacterBody3D


@onready var label_3d: Label3D = $Label3D
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@export var npc_stats: base_npc


var head_shot_multi: float = 2.0
var base_dmg_multi: float = 1.0
var alive: bool = true
var player:CharacterBody3D
var stats: base_npc


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	

	label_3d.text = "test2"
	navigation_agent_3d.max_speed = 50
	
func _physics_process(delta: float) -> void:

	navigation_agent_3d.set_target_position(player.global_position)
	
	var next_path_position: Vector3 = navigation_agent_3d.get_next_path_position()
	var look_at_pos = Vector3(next_path_position.x, global_position.y, next_path_position.z)
	if not global_position.is_equal_approx(look_at_pos):
		look_at(look_at_pos,Vector3.UP)
	velocity = global_position.direction_to(next_path_position) * Vector3(1,0,1)
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

	
func dead():
	if alive:
		alive = false
		
		
	
func hit(source, damaged_part: Node3D):
	var multi_dmg: float = damaged_part.get_meta("dmg_mul", 1.0)
	if is_instance_of(source, Projectile):
		stats.hp -= source.projectile_data.damage * multi_dmg
	elif is_instance_of(source, MeleeWeapon):
		stats.hp -= source.weapon_data.base_damage * multi_dmg
	label_3d.text = str(stats.hp)
	if stats.hp <=0:
		dead()
