class_name Player extends CharacterBody2D

@export_category("Stats")
@export var speed: float = 100.0
@export var acceleration: float = 100.0
@export var friction: float = 100.0


func _physics_process(delta: float) -> void:
	var direction = handle_movement(delta)
	handle_gravity(delta)
	move_and_slide()

#region Movement methods
func handle_movement(delta: float) -> float:
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity = velocity.move_toward(Vector2(direction, 0) * speed, delta * acceleration)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	return direction

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y *= -speed
#endregion
