class_name WeaponManager extends Node3D

var weapon_list = []
var equiped_weapon: Node3D

func _ready() -> void:
	Globals.pick_up_weapon.connect(obtain_weapon)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("Attack") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		equiped_weapon.fire()
func obtain_weapon(new_weapon: WeaponData):
	var arm: Node3D = Globals.player.arm
	var weapon_model = new_weapon.weapon_scene.instantiate()
	equiped_weapon = weapon_model
	arm.add_child(weapon_model)


func switch_weapon(direction: String):
	if direction == "next":
		var arm: Node3D = Globals.player.arm
		arm.get_child(0).queue_free()
		

func weapon_attack():
	pass
	
func weapon_reload():
	pass
