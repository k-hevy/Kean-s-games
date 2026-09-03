class_name Slot
extends Panel

@export var upgrade_type: Enums.UpgradeType

@export var texture_upgrade: TextureRect
@export var name_upgrade: Label
@export var level_upgrade: Label
@export var cost_upgrade: Label
@export var button_upgrade: Button


func _ready() -> void:
	pass
	
	
func _on_button_upgrade_pressed() -> void:
	EventBus.buy_clicked.emit(self)
	#tells that this button was pressed and emits this signal


func update_upgrade_slot(title_text: String, level: int, cost: float) -> void:
	name_upgrade.text = title_text 
	level_upgrade.text =  " (Lvl " + str(level) + ")"
	cost_upgrade.text = "Cost: " + str(snapped(cost, 0.1)) + " Water"
	
func set_icon(new_texture: PortableCompressedTexture2D):
	if new_texture:
		$MarginContainer/VBoxContainer/Texture.texture = new_texture
	else:
		$MarginContainer/VBoxContainer/Texture.texture = preload("res://icon.svg")
