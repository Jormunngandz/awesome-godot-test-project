class_name WeaponManager extends Node3D

var weapon_list: Array
var current_weapon_index: int
var equiped_weapon_scene: Node3D
enum WEAPON_STATES {READY, UNEQUPED, SWITCHING}
var current_states  = WEAPON_STATES.UNEQUPED
func _ready() -> void:
	Globals.pick_up_weapon.connect(obtain_weapon)


func _physics_process(_delta: float) -> void:
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED and current_states == WEAPON_STATES.READY:
		if Input.is_action_just_pressed("Attack"):
			if is_instance_of(equiped_weapon_scene, FireWeapon):
				equiped_weapon_scene.fire(weapon_list[current_weapon_index])
			elif is_instance_of(equiped_weapon_scene, MeleeWeapon):
				equiped_weapon_scene.attack(weapon_list[current_weapon_index])
		elif Input.is_action_just_pressed("next_weapon"):
			switch_weapon("next")
		elif Input.is_action_just_pressed("prev_weapon"):
			switch_weapon("prev")
		
			
		
func obtain_weapon(new_weapon: WeaponData):
	current_states = WEAPON_STATES.UNEQUPED
	var arm: Node3D = Globals.player.arm
	if arm.get_child_count():
		arm.get_child(0).queue_free()
	var weapon_model = new_weapon.weapon_scene.instantiate()
	equiped_weapon_scene = weapon_model
	
	weapon_list.append(new_weapon)
	current_weapon_index = weapon_list.size() - 1
	arm.add_child(weapon_model)
	current_states = WEAPON_STATES.READY


func switch_weapon(direction: String):
	current_states = WEAPON_STATES.SWITCHING
	if direction == "next":
		current_weapon_index += 1
		if current_weapon_index >= weapon_list.size():
			current_weapon_index = 0
	elif direction == "prev":
		current_weapon_index -= 1
	var arm: Node3D = Globals.player.arm
	arm.get_child(0).queue_free()
	var weapon_model = weapon_list[current_weapon_index].weapon_scene.instantiate()
	equiped_weapon_scene = weapon_model
	arm.add_child(equiped_weapon_scene)
	current_states = WEAPON_STATES.READY
		

func weapon_attack():
	pass
	
func weapon_reload():
	pass
