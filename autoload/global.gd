extends Node

var sensitivity := 1.0

# Прохождение уровней также можно сохранить
# Например, для блокирования всех уровней кроме первого
# в начале игры

var init_pos: Vector2i

func _ready() -> void:
	init_pos = get_viewport().get_window().position

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ENTER and event.pressed and event.alt_pressed:
			
			if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				await get_viewport().size_changed
				get_viewport().get_window().position = init_pos
