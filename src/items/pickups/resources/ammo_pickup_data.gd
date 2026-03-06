class_name AmmoPickupData extends BasePickupData

@export var ammo_for: WeaponData



func pick(_target:CharacterBody3D) -> bool:
	
	for weapon_data:WeaponData in Globals.player.weapon_manager.weapon_list: 
		if weapon_data.name == ammo_for.name:
			Messager.ammo_picked.emit(self)
			return true
				
	return false
