class_name AmmoPickupData extends BasePickupData

func pick(target:CharacterBody3D) -> bool:
	
	if not target.arm or target.arm.get_child_count() == 0:
		print("no weapon equiped")
		return false
	print("ammo added")
	#Globals.player.weapon_manager.equiped_weapon.
	#var weapon = target.arm.get_child(0)
	#weapon.refill(value)
	return true
