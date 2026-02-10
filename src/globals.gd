extends Node
signal stat_change
var player_heal:float = 100.0:
	set(value):
		player_heal = value
		stat_change.emit()

var player_stamina:float = 100.0:
	set(value):
		if value > player_stamina:
			player_stamina = min(value, 100)
		else:
			player_stamina = max(value, 0)
		stat_change.emit()
