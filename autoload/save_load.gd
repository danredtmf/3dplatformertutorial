extends Node

const SETTINGS_DATA_PATH := "user://settings.data"

var settings_data_template := {
	"sensitivity": 0.0,
}

func _ready() -> void:
	load_data()

func save_data() -> void:
	var file := FileAccess.open(SETTINGS_DATA_PATH, FileAccess.WRITE)
	var settings_data := settings_data_template.duplicate()
	
	settings_data.sensitivity = Global.sensitivity
	file.store_string(JSON.stringify(settings_data))

func load_data() -> void:
	if FileAccess.file_exists(SETTINGS_DATA_PATH):
		var file := FileAccess.open(SETTINGS_DATA_PATH, FileAccess.READ)
		var parsed_data = JSON.parse_string(file.get_as_text())
		
		if parsed_data is Dictionary:
			if parsed_data.has("sensitivity"):
				if parsed_data.sensitivity >= 0.01:
					Global.sensitivity = parsed_data.sensitivity
