class_name AmmoData extends ItemData


func use(target:CharacterBody3D) -> bool:
	if not target.arm:
		return false
		
	var weapon = target.arm.get_child(0)
	weapon.refill(value)
	return true
