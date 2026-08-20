extends CharacterBody2D

@export var debug_velocity: Vector2
@export var direction_x: float
@export var speed: int = 300
@export var jump_strength: int  = 200
@export var gravity: int = 800

func _physics_process(_delta: float) -> void:
	get_input()
	apply_gravity(_delta)
	move_and_slide()
		
func get_input() -> void:
	direction_x = Input.get_axis("left", "right")
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = - jump_strength
	
	velocity.x = direction_x * speed
	debug_velocity = velocity

func apply_gravity(_delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * _delta
	
