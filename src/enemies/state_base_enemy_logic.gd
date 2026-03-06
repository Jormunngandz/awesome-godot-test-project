class_name StateBaseEnemyLogic extends BaseEnemyLogic

@export var animation_player: AnimationPlayer
@export var animation_tree: AnimationTree
var state_machine


func _ready() -> void:
	if head_area:
		head_area.set_meta("dmg_mul", npc_stats.head_shot_multi)
		#print(head_area)
		#print(head_area.get_meta("dmg_mul"))
	body_collision.set_meta("dmg_mul", npc_stats.base_dmg_multi) 
	stats = npc_stats.duplicate()
	navigation_agent.max_speed = stats.max_speed
	state_machine = animation_tree.get("parameters/playback")
	
func _physics_process(delta: float) -> void:
	match state_machine.get_current_node():
		"Walk_an":
			walk_to_target(delta)
	set_new_state()
	

func set_new_state():
	animation_tree.set("parameters/conditions/enemy_detected", is_in_aggro_range() and !target_in_range())
	animation_tree.set("parameters/conditions/idle", !is_in_aggro_range())
	animation_tree.set("parameters/conditions/attack", target_in_range())
	animation_tree.set("parameters/conditions/dead", stats.hp <= 0)

func target_in_range():
	return attack_raycast.get_collider() == Globals.player

func is_in_aggro_range():
	return global_position.distance_to(Globals.player.global_position) < stats.aggro_range
