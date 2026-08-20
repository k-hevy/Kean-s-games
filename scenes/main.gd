extends Node2D

const RAINDROP_SCENE = preload("res://scenes/raindrop.tscn")

@onready var water_score = $UI/Water_Score
@onready var token_score = $UI/Token_Score

func _physics_process(_delta: float) -> void:
	set_labels()


func _on_timer_timeout() -> void:
	var rain_drop = RAINDROP_SCENE.instantiate() as Area2D
	var width = 150.0
	var random = randf_range(-width /2, width /2)
	rain_drop.global_position = $Cloud.global_position + Vector2(random, 0)
	$RainDrops.add_child(rain_drop)
	
	
func set_labels() -> void:
	water_score.text = "Water: " + str(Global.water)
	token_score.text = "Tokens: " + str(Global.tokens)
	
	
