class_name PlayerManager extends Node

var is_vulnerable: bool = true

var player_heal:float = 100.0:
	set(value):
		player_heal = max(value, 0)
		Globals.stat_change.emit()
		if player_heal == 0:
			print("player is dead")
		

var player_stamina:float = 100.0:
	set(value):
		if value > player_stamina:
			player_stamina = min(value, 100)
		else:
			player_stamina = max(value, 0)
		Globals.stat_change.emit()

func hit(hitted_by, _collision):
	if not is_vulnerable:
		print("asd")
		return

	if hitted_by is Projectile:
		Globals.player.player_manager.player_heal -= hitted_by.projectile_stats.damage
	elif hitted_by is MeleeWeapon:
		Globals.player.player_manager.player_heal -= hitted_by.weapon_data.base_damage
	is_vulnerable = false
	var invulnerable_timer = Timer.new()
	add_child(invulnerable_timer)
	invulnerable_timer.start(3)
	invulnerable_timer.connect("timeout",func (): is_vulnerable = true)
	await invulnerable_timer.timeout
	invulnerable_timer.queue_free()
		
