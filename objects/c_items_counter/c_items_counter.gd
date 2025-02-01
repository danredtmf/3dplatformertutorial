class_name CItemsCounter extends Node3D

# Максимальное количество собираемых предметов на уровне
var items_max := 0
# Текущее количество собранных предметов на уровне
var items_count := 0

func _ready() -> void:
	var items_in_level := get_tree().get_nodes_in_group("CollectableItem")
	if items_in_level.size() > 0:
		items_max = items_in_level.size()
		for item: CollectableItem in items_in_level:
			item.take_item.connect(_on_take_item.bind())

func _on_take_item() -> void:
	items_count += 1
	print("Всего взял предметов: %s" % [items_count])
