class_name StatePlayer
extends State

enum Element {
	NEUTRAL,
	CYAN,
	MAGENTA,
	YELLOW,
}

@export var animation_player: AnimationPlayer = null


# Get the current normalized direction that Kuro is facing
func get_direction() -> Vector2:
	return get_controller().get_direction()


# Get the current direction string describing Kuro's facing
# Used for picking animations and sprites
func get_direction_string() -> String:
	return get_controller().get_direction_string()


# Get the normalized movement input for the player
func get_movement_vector() -> Vector2:
	return Input.get_vector( "pl_left", "pl_right", "pl_up", "pl_down" )


# Update Kuro's current facing direction
func update_direction( dir: Vector2 ) -> void:
	get_controller().update_direction( dir )


func _start( _params: Dictionary = {} ) -> void:
	# Get the first AnimationPlayer if none specified
	if animation_player == null:
		for child in get_controller().get_children():
			if child is AnimationPlayer:
				animation_player = child
				break
