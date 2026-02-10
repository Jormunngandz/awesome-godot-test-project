extends CanvasLayer

@onready var hp_bar: ProgressBar = %HPBar
@onready var stamina_bar: ProgressBar = %StaminaBar
@onready var enemy_name_label: Label = %EnemyNameLabel
@onready var enemy_hp_bar: ProgressBar = %EnemyHPBar
@onready var enemy_box: VBoxContainer = %EnemyBox
@onready var hide_enemy_box_timer: Timer = %HideEBTimer

var current_target: CharacterBody3D

func _ready() -> void:
	Globals.stat_change.connect(update_elemets)
	Messager.new_enemy_spotted.connect(get_new_target)
	enemy_box.visible = false
	
	
func _process(_delta: float) -> void:
	if current_target:
		update_enemy_elements()
		
func update_elemets():
	update_stamina()
	update_hp_bar()

func update_stamina():
	stamina_bar.value = Globals.player_stamina
	
	
func update_hp_bar():
	hp_bar.value = Globals.player_heal

func get_new_target(new_target):
	if new_target and new_target.is_in_group("Enemy"):
		current_target = new_target
		enemy_box.visible = true
		hide_enemy_box_timer.start(5)
	
	
func update_enemy_elements():
	if current_target.stats.hp <= 0:
		enemy_box.visible = false
		current_target = null
		return
	enemy_hp_bar.value = current_target.stats.hp
	enemy_name_label.text = current_target.stats.name
	



func _on_hide_eb_timer_timeout() -> void:
	enemy_box.visible = false
	current_target = null
