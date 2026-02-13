class_name WeaponPickupData extends BasePickupData

@export var pick_obj: WeaponData

func pick(target:CharacterBody3D) -> bool:
	if not target.arm:
		return false
	Globals.pick_up_weapon.emit(pick_obj)
	return true
