class_name AboutState extends Control

@export var main_menu: MainMenu

@onready var engine_name: Label = %EngineName

func _ready() -> void:
	var engine := Engine.get_version_info()
	engine_name.text = "Godot Engine %s.%s.%s-%s" % [engine.major, engine.minor, engine.patch, engine.status]

# Нужно привязать сигнал "pressed" у кнопки "Back"
func _on_back_pressed() -> void:
	main_menu.set_state(main_menu.States.Main)
