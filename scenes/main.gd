extends Node2D

const RAINDROP_SCENE = preload("res://scenes/raindrop.tscn")
@onready var cloud1 := %Cloud1
@onready var cloud2 := %Cloud2


func _ready() -> void:
	cloud1.spawn_raindrop.connect(_on_spawn_drop)
	cloud2.spawn_raindrop.connect(_on_spawn_drop)


func spawn_cloud() -> void:
	pass


func _on_spawn_drop(drop_pos : Vector2) -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	rain_drop.global_position = drop_pos
	$RainDrops.add_child(rain_drop)
