class_name StatePlayer
extends State

const STRING_LEFT: String = "left"
const STRING_RIGHT: String = "right"
const STRING_UP: String = "up"
const STRING_DOWN: String = "down"

var _direction: Vector2 = Vector2.DOWN
var _direction_string: String = STRING_DOWN


# Get the current normalized direction that Kuro is facing
func get_direction() -> Vector2:
	return _direction


# Get the current direction string describing Kuro's facing
# Used for picking animations and sprites
func get_direction_string() -> String:
	return _direction_string


# Get the normalized movement input for the player
func get_movement_vector() -> Vector2:
	return Input.get_vector( "pl_left", "pl_right", "pl_up", "pl_down" )


# Update Kuro's current facing direction
func update_direction( dir: Vector2 ) -> void:
	if dir.length_squared() > 0.0:
		_direction = dir.normalized()
		var left_speed = dir.dot( Vector2.LEFT )
		var right_speed = dir.dot( Vector2.RIGHT )
		var up_speed = dir.dot( Vector2.UP )
		var down_speed = dir.dot( Vector2.DOWN )
		var max_speed = max( left_speed, right_speed, up_speed, down_speed )
		
		# Only update if the direction has changed/if prior direction is no longer appropriate
		var cur_dir = get_direction_string()
		if (cur_dir == STRING_LEFT and left_speed < max_speed) \
				or (cur_dir == STRING_RIGHT and right_speed < max_speed) \
				or (cur_dir == STRING_UP and up_speed < max_speed) \
				or (cur_dir == STRING_DOWN and down_speed < max_speed):
			# Preferentially pick left/right
			if max_speed == left_speed:
				_direction_string = STRING_LEFT
			elif max_speed == right_speed:
				_direction_string = STRING_RIGHT
			elif max_speed == up_speed:
				_direction_string = STRING_UP
			elif max_speed == down_speed:
				_direction_string = STRING_DOWN
