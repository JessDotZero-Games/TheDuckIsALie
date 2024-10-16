class_name Player extends CharacterBody2D

# Components
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var sprite_2d: Sprite2D = $Sprite2D

# Attributes
@export_category("Stats")
@export var speed: float = 150.0
@export var acceleration: float = 300.0
@export var friction: float = 500.0
@export var jump_speed: float = 300.0

#region Built-in methods

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	var direction = handle_movement(delta)
	handle_gravity(delta)
	change_animation()
	change_animation_direction(direction)
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Up") and is_on_floor():
		handle_jump()

#endregion

#region Movement methods

func handle_movement(delta: float) -> float:
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity = velocity.move_toward(Vector2(direction, 0) * speed, delta * acceleration)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	return direction

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_jump() -> void:
	velocity.y = -jump_speed 

#endregion

#region Animations methods

func change_animation() -> void:
	if velocity != Vector2.ZERO:
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	
func change_animation_direction(direction):
	if direction != 0:
		sprite_2d.flip_h = direction < 0

#endregion
