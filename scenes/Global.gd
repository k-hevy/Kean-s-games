extends Node

# Currencies
var water: float = 100_000
var tokens: float = 0

# Upgrades
var bucket_capacity_level = 0
var speed_level = 0
var empty_speed_level = 0

# Getters for Calculated Effects

func get_bucket_capacity() -> float:
	var base_bucket_capacity = 25.0
	var multiplier = 1.3
	return base_bucket_capacity * pow(multiplier, bucket_capacity_level)
	
func get_speed() -> float:
	var base_speed = 200.0
	var bonus_per_level = 20.0
	return base_speed + (speed_level * bonus_per_level)
	
func get_empty_speed() -> float:
	var base_empty_speed = 5.0
	var multiplier = 50.0
	return base_empty_speed * pow(multiplier, empty_speed_level)
	
# Upgrade Costs
	
func get_bucket_capacity_cost() -> float:
	var base_cost = 15.0
	var multiplier = 1.4
	return base_cost * pow(multiplier, bucket_capacity_level)

func get_speed_cost() -> float:
	var base_cost = 15.0
	var multiplier = 1.4
	return base_cost * pow(multiplier, speed_level)
	
func get_empty_speed_cost() -> float:
	var base_cost = 15.0
	var multiplier = 1.4
	return base_cost * pow(multiplier, empty_speed_level)

# Upgrades

func bucket_capacity_upgrade() -> void:
	var cost = get_bucket_capacity_cost()
	if bucket_capacity_level < 10 and water >= cost:
		water -= cost
		bucket_capacity_level += 1
		
func speed_level_upgrade() -> void:
	var cost = get_speed_cost()
	if speed_level < 10 and water >= cost:
		water -= cost
		speed_level += 1
		
func empty_speed_upgrade() -> void:
	var cost = get_empty_speed_cost()
	if empty_speed_level < 10 and water >= cost:
		water -= cost
		empty_speed_level += 1
