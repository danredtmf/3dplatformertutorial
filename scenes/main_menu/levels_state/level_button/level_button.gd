class_name LevelButton extends Button

@export var level: PackedScene
@export var level_idx: int

func _ready() -> void:
	text = "%s" % [level_idx]

# Нужно привязать сигнал "pressed" у обладателя данного скрипта
func _on_pressed() -> void:
	get_tree().change_scene_to_packed(level)
