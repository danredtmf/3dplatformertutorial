class_name CItemsCounterUI extends Control

var counter: CItemsCounter

@onready var info: Label = $Margin/BoxContainer/Info

func _ready() -> void:
	var first_in_group = get_tree().get_first_node_in_group("CItemsCounter")
	if first_in_group != null:
		counter = first_in_group

func _process(_delta: float) -> void:
	if counter != null:
		info.text = "Предметов: %s / %s" % [counter.items_count, counter.items_max]
