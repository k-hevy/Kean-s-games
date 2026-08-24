extends Node2D

const RAINDROP_SCENE = preload("res://scenes/raindrop.tscn")

@onready var water_score = $UI/Water_Score
@onready var token_score = $UI/Token_Score

func _ready() -> void:
	$Cloud.spawn_raindrop.connect(_on_spawn_drop)
	
	
func _physics_process(_delta: float) -> void:
	set_labels()
	

func set_labels() -> void:
	water_score.text = "Water: " + str(Global.water)
	token_score.text = "Tokens: " + str(Global.tokens)
	
	
func spawn_cloud() -> void:
	pass
	
	
	
	
func _on_spawn_drop(drop_pos : Vector2) -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	rain_drop.global_position = drop_pos
	$RainDrops.add_child(rain_drop)
