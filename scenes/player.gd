extends CharacterBody2D

@export var debug_velocity: Vector2
@export var direction_x: float
@export var jump_strength: int  = 200
@export var gravity: int = 800

@export var player_speed: int = 200
@export var empty_speed = 10
@export var bucket_capacity = 25

func _ready() -> void:
	Global.upgrade_purchased.connect(_on_purchase_upgrade)
	player_speed = Global.get_effect("player_speed")
	empty_speed = Global.get_effect("empty_speed")
	bucket_capacity = Global.get_effect("bucket_capacity")

func _physics_process(_delta: float) -> void:
	get_input()
	apply_gravity(_delta)
	move_and_slide()
	
	
# Updates Player Stats through a match
func _on_purchase_upgrade(upgrade_name: String, new_value: float) -> void:
	match upgrade_name:
		"player_speed":
			player_speed = new_value
		"empty_speed":
			empty_speed = new_value
		"bucket_capacity":
			bucket_capacity = new_value
			
	
		
func get_input() -> void:
	direction_x = Input.get_axis("left", "right")
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = - jump_strength
	
	velocity.x = direction_x * player_speed
	debug_velocity = velocity

func apply_gravity(_delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * _delta
	
