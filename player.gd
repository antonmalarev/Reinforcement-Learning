extends CharacterBody2D

var path = [Vector2(0, 0), Vector2(0, 1), Vector2(1, 1), Vector2(1, 2), Vector2(2, 2), 
			Vector2(2, 3), Vector2(3, 3), Vector2(4, 3), Vector2(4, 4)]
var tile_size = 25  # Adjust to your TileMap size
var is_moving = false
var current_index = 0  # Track movement progress

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	#update_animation_parameters(starting_direction)
	position = path[0] * tile_size  # Start at first position
	move_along_path()

func move_along_path():
	await get_tree().create_timer(1.0).timeout  # Wait before starting
	for i in range(1, path.size()):  # Start from 1 (skip initial position)
		var target_pos = path[i] * tile_size
		var direction = (path[i] - path[i - 1]).normalized()
		await move_player(target_pos, direction)
		await get_tree().create_timer(0.5).timeout  # Wait before next move

func _physics_process(_delta):
	# Get input direction:
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	update_animation_parameters(input_direction)
	# Update velocity
	velocity = input_direction * move_speed
	# Move and Slide function uses velocity of character body to move character on map
	move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no move input
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
	
func move_player(target_pos, direction):
	if is_moving:
		return
	is_moving = true
	var tween = get_tree().create_tween()
	# Smooth movement animation
	tween.tween_property(self, "position", target_pos, 0.3).set_trans(Tween.TRANS_LINEAR)
	# Update animation direction
	update_animation_parameters(direction)
	await tween.finished
	is_moving = false
