extends Node

# Сигналы для взаимодействия
# interactive_ui_shown - показать интерфейс взаимодействия
# interactive_ui_hide - скрыть интерфейс
# interactive_item_interacted - объект был использован
signal interactive_ui_shown(item)
signal interactive_ui_hide
signal interactive_item_interacted(item)
