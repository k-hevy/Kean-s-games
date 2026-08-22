extends Node

# Loads the Json file upon Loading
func _ready() -> void:
	var file =  FileAccess.open("res://data/upgrades.json", FileAccess.READ)
	upgrade_data = JSON.parse_string(file.get_as_text())

# load JSON For prices and values: bucket_capacity, player_speed, empty_speed
var upgrade_data: Dictionary = {}

# Contains current levels (Persistent levels have not been achieved)
var levels: Dictionary = {
	"bucket_capacity": 0,
	"player_speed": 0,
	"empty_speed": 0
}

# Currencies
var water: float = 100_000
var tokens: float = 0


# Getters for Effects
func get_effect(upgrade_name: String) -> float:
	var level = levels[upgrade_name]
	return upgrade_data[upgrade_name]["values"][level]

# Getter for Cost
func get_cost(upgrade_name: String) -> float:
	var level = levels[upgrade_name]
	return upgrade_data[upgrade_name]["costs"][level]

# Updates Upgrades (Levels set to 10)
func buy_upgrade(upgrade_name: String) -> void:
	var cost = get_cost(upgrade_name)
	if levels[upgrade_name] < 10 and water >= cost:
		water -= cost
		levels[upgrade_name] += 1
