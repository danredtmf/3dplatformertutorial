class_name PlayerRayCast extends RayCast3D

var _last_object: InteractiveItem

func _physics_process(_delta: float) -> void:
	force_raycast_update()
	if is_colliding():
		var object := get_collider()
		if object is InteractiveItem:
			if not object.disabled:
				if _last_object == null or object != _last_object:
					_last_object = object
					EventBus.interactive_ui_shown.emit(object)
				elif object == _last_object:
					EventBus.interactive_ui_shown.emit(null)
			else:
				EventBus.interactive_ui_hide.emit()
		else:
			EventBus.interactive_ui_hide.emit()
	else:
		EventBus.interactive_ui_hide.emit()
