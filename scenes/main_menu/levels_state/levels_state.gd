class_name LevelsState extends Control

const MIN_LEVEL_IDX := 1
const LEVEL_BUTTON := preload("res://scenes/main_menu/levels_state/level_button/level_button.tscn")

@export var main_menu: MainMenu

var levels_path := "res://scenes/levels/"
var found_levels := []
var found_level_template := {
	"idx": 0,
	"path": "",
}

@onready var levels: HBoxContainer = %Levels

func _ready() -> void:
	find_levels()

# Поиск уровней в игре
# Важно соблюдать правила наименований папок с уровнями
func find_levels() -> void:
	var current_idx := MIN_LEVEL_IDX
	var current_level_folder := levels_path + "%s/" % [current_idx]
	while DirAccess.dir_exists_absolute(current_level_folder):
		var current_level := current_level_folder + "level.tscn"
		if FileAccess.file_exists(current_level):
			var new_level := found_level_template.duplicate()
			new_level.idx = current_idx
			new_level.path = current_level
			found_levels.append(new_level)
			
			current_idx += 1
			current_level_folder = levels_path + "%s/" % [current_idx]
	load_levels()

func load_levels() -> void:
	for current_level: Dictionary in found_levels:
		var level_button := LEVEL_BUTTON.instantiate()
		level_button.level_idx = current_level.idx
		level_button.level = load(current_level.path)
		levels.add_child(level_button)

# Нужно привязать сигнал "pressed" у кнопки "Back"
func _on_back_pressed() -> void:
	main_menu.set_state(main_menu.States.Main)
