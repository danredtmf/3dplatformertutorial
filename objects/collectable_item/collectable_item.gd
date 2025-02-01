class_name CollectableItem extends Area3D

signal take_item

# Привяжите сигнал "on_body_entered" объекта "CollectableItem" к самому себе,
# чтобы данная функция (будет пустой) сама встроилась в код и работала
func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		take_item.emit()
		queue_free()
