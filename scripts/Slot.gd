class_name Slot
extends Panel

@export var texture_upgrade: TextureRect
@export var name_upgrade: Label
@export var level_upgrade: Label
@export var cost_upgrade: Label
@export var button_upgrade: Button

signal buy_clicked

func _ready() -> void:
	pass
	
	
func _on_button_upgrade_pressed() -> void:
	buy_clicked.emit()
	#tells that this button was pressed and emits this signal


func update_upgrade_slot(title_text: String, level: int, cost: float) -> void:
	name_upgrade.text = title_text 
	level_upgrade.text =  " (Lvl " + str(level) + ")"
	cost_upgrade.text = "Cost: " + str(snapped(cost, 0.1)) + " Water"
