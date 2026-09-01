extends Node2D

const RAINDROP_SCENE = preload("res://scenes/objects/raindrop.tscn")
const CLOUD_SCENE = preload("res://scenes/objects/cloud.tscn")

# Open 
const CLOUD_VARIANTS_PATH = "res://data/cloud_variants.json"
var cloud_variants: Dictionary 


func _ready() -> void:
	EventBus.spawn_raindrop.connect(_on_spawn_drop)
	var file = FileAccess.open(CLOUD_VARIANTS_PATH, FileAccess.READ)
	cloud_variants = JSON.parse_string(file.get_as_text())


func _on_spawn_drop(drop_pos : Vector2, base: float) -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	rain_drop.global_position = drop_pos
	rain_drop.base_value = base
	%RainDrops.add_child(rain_drop)


func _on_spawn_cloud_timeout() -> void:
	
	var cloud = CLOUD_SCENE.instantiate() as Area2D
	
	var random_key = cloud_variants.keys().pick_random() # gets random key
	var data = cloud_variants[random_key] # accesses variant
	
	cloud.global_position = %Cloud_Spawnpoint.position
	cloud.speed = data["speed"]
	cloud.size = data["size"]
	cloud.rain_drop_spawn_interval = data["rain_drop_spawn_interval"]
	cloud.base_value = data["base_value"]
	cloud.MAX_LIFESPAN = data["max_lifespan"]
	cloud.texture = data["texture"]
	%Clouds.add_child(cloud)	
