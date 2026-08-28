extends Node2D

const RAINDROP_SCENE = preload("res://scenes/raindrop.tscn")
const CLOUD_SCENE = preload("res://scenes/cloud.tscn")


func _ready() -> void:
	pass


func _on_spawn_drop(drop_pos : Vector2) -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	rain_drop.global_position = drop_pos
	%RainDrops.add_child(rain_drop)


func _on_spawn_cloud_timeout() -> void:
	var cloud = CLOUD_SCENE.instantiate() as Area2D
	cloud.global_position = %Cloud_Spawnpoint.position
	cloud.spawn_raindrop.connect(_on_spawn_drop)
	%Clouds.add_child(cloud)
