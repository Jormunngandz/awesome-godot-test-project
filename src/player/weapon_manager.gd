class_name WeaponManager extends Resource

var weapon_list = []
var equiped_weapon: Node3D

func obtain_weapon(new_weapon: Node3D):
	pass

func switch_weapon(direction: String):
	if direction == "next":
		var arm: Node3D = Globals.player.arm
		arm.get_child(0).queue_free()
		

func weapon_attack():
	pass
	
func weapon_reload():
	pass
