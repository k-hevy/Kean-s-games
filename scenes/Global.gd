extends Node


const SAVE_PATH := "res://data/player_data.json"
const UPGRADE_PATH := "res://data/upgrades.json"

# Currencies
var water: float = 100_000
var tokens: float = 0

# load JSON For prices and values: bucket_capacity, player_speed, empty_speed
var upgrade_data: Dictionary = {}

# Contains current levels (Persistent levels have not been achieved)
var levels: Dictionary = {
	"bucket_capacity": 0, 
	"player_speed": 0, 
	"empty_speed": 0, 
	"raindrop_value": 0 
}


# Loads the Json file upon Loading
func _ready() -> void:
	print(levels)
	load_game() # loads previous data

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
func get_effect(type: Enums.UpgradeType) -> float:
	var upgrade_name = get_string_key(type)
	var level = levels.get(upgrade_name, 0)
	return upgrade_data[upgrade_name]["values"][level]


# Getter for Cost
func get_cost(type: Enums.UpgradeType) -> float:
	var upgrade_name = get_string_key(type)
	var level = levels.get(upgrade_name, 0)
	return upgrade_data[upgrade_name]["costs"][level]


func get_level(type: Enums.UpgradeType)  -> int:
	var upgrade_name = get_string_key(type)
	return levels.get(upgrade_name, 0)
# returns a level of an upgrade


# Updates Upgrades (Levels set to 10)
func buy_upgrade(type: Enums.UpgradeType) -> void:
	var key = get_string_key(type)
	# Return if max level
	if levels[key] >= 9: 
		return
		
	var cost = get_cost(type)
	if water >= cost:
		water -= cost
		levels[key] += 1
		
		# Siganl is emitted to update player
		var new_value = get_effect(type)
		EventBus.upgrade_purchased.emit(key, new_value)
		save_game()


# A helper method to transform Enums to Strings
func get_string_key(type: Enums.UpgradeType) -> String:
	match type:
		Enums.UpgradeType.BUCKET_CAPACITY: return "bucket_capacity"
		Enums.UpgradeType.PLAYER_SPEED: return "player_speed"
		Enums.UpgradeType.EMPTY_SPEED: return "empty_speed"
		Enums.UpgradeType.RAINDROP_VALUE: return "raindrop_value"
	return ""
