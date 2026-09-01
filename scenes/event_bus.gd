extends Node

#UI
signal spawn_text(text: String, pos: Vector2)
signal shop_open()
signal shop_close()
signal upgrade_purchased(upgrade_name: String, new_value: float)
signal buy_clicked(slot_node: Slot)
signal spawn_raindrop(spawn_pos: Vector2, base_value: float)
