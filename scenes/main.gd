extends Node2D

const RAINDROP_SCENE = preload("res://scenes/objects/raindrop.tscn")
const CLOUD_SCENE = preload("res://scenes/objects/cloud.tscn")

# Open 
const CLOUD_VARIANTS_PATH = "res://data/cloud_variants.json"
var cloud_variants: Dictionary 


func _ready() -> void:
	var file = FileAccess.open(CLOUD_VARIANTS_PATH, FileAccess.READ)
	cloud_variants = JSON.parse_string(file.get_as_text())
	var method_owner = %Game_Hud.get_node("Hud_Manager/Text_Spawner")
	var bucket = $Player.get_node("Bucket")
	bucket.spawn_text.connect(method_owner._spawn_pop_text)

func _on_spawn_drop(drop_pos : Vector2) -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	rain_drop.global_position = drop_pos
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
	cloud.spawn_raindrop.connect(_on_spawn_drop)
	%Clouds.add_child(cloud)

	
