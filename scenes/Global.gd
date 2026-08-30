extends Node

#signal for a succesful upgrade
signal upgrade_purchased(upgrade_name: String, new_value: float)

const SAVE_PATH := "res://data/player_data.json"
const UPGRADE_PATH := "res://data/upgrades.json"

# load JSON For prices and values: bucket_capacity, player_speed, empty_speed
var upgrade_data: Dictionary = {}

# Contains current levels (Persistent levels have not been achieved)
var levels: Dictionary = {
	"bucket_capacity": 0,
	"player_speed": 0,
	"empty_speed": 0,
	"raindrop_value": 0
}

# Currencies
var water: float = 100_000
var tokens: float = 0


# Loads the Json file upon Loading
func _ready() -> void:
	
	# loads previous data
	load_game()
	
	# Loads Upgrade data
	var file =  FileAccess.open(UPGRADE_PATH, FileAccess.READ) # gets read-only file
	upgrade_data = JSON.parse_string(file.get_as_text()) # Converts to String
	file.close()
	

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		return # If first launch then use defaults Note: Neeed to create a file first
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var player_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if player_data:
		tokens = player_data.get("tokens", 0)
		water = player_data.get("water", 0)
		levels = player_data.get("levels", 0)
		
	
func save_game() -> void:
	var save_data = {
		"tokens": tokens,
		"water": water,
		"levels": levels
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()

# Getters for Effects
func get_effect(upgrade_name: String) -> float:
	var level = levels.get(upgrade_name, 0)
	return upgrade_data[upgrade_name]["values"][level]

# Getter for Cost
func get_cost(upgrade_name: String) -> float:
	var level = levels.get(upgrade_name)
	return upgrade_data[upgrade_name]["costs"][level]

# Updates Upgrades (Levels set to 10)
func buy_upgrade(upgrade_name: String) -> void:
	
	# Return if max level
	if levels[upgrade_name] >= 10:
		return
		
	var cost = get_cost(upgrade_name)
	if water >= cost:
		water -= cost
		levels[upgrade_name] += 1
		
		# Siganl is emitetd to update player
		var new_value = get_effect(upgrade_name)
		upgrade_purchased.emit(upgrade_name, new_value)
		save_game()
		print("saved")
