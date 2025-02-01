class_name Portal extends Area3D

@export var is_end: bool
@export var is_touchable: bool = true
@export var next_portal: Portal
@export var next_level: PackedScene

var c_items_counter: CItemsCounter

@onready var forward_pos: Marker3D = $ForwardPos
@onready var forward_look_pos: Marker3D = $ForwardLookPos

func _ready() -> void:
	if not is_end:
		set_process(false)
	else:
		var c_items_counter_find = get_tree().get_first_node_in_group("CItemsCounter")
		if c_items_counter_find == null:
			set_process(false)
			print("Последний портал: \"Никто не считает предметы... ну и ладно\"")
		else:
			c_items_counter = c_items_counter_find
			is_touchable = false

func get_global_forward_position() -> Vector3:
	return forward_pos.global_position

func set_player_look_at_forward_position(player: Player) -> void:
	player.look_at(forward_look_pos.global_position)

# Будет работать только если портал является последним и игрок не собрал все предметы
func _process(_delta: float) -> void:
	if c_items_counter.items_count >= c_items_counter.items_max:
		print("Портал увидел, что игрок собрал все предметы и он разблокировался!")
		is_touchable = true
		set_process(false)

# Нужно привязать сигнал "_on_body_entered" у обладателя данного скрипта
func _on_body_entered(body: Node3D) -> void:
	if body is Player and is_touchable:
		if not is_end:
			next_portal.is_touchable = false
			body.global_position = next_portal.get_global_forward_position()
			next_portal.set_player_look_at_forward_position(body)
			await get_tree().create_timer(0.25).timeout
			next_portal.is_touchable = true
		else:
			if next_level:
				get_tree().call_deferred("change_scene_to_packed", next_level)
			else:
				# вместо строки `get_tree().quit()`
				get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu/main_menu.tscn")
