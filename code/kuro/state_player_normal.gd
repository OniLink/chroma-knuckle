class_name StatePlayerNormal
extends StatePlayer

const WALK_SPEED: float = 100.0
const STRING_LEFT: String = "left"
const STRING_RIGHT: String = "right"
const STRING_UP: String = "up"
const STRING_DOWN: String = "down"

@export var sprite: AnimatedSprite2D = null

var _direction_string: String = STRING_DOWN


func _update( _dt: float ) -> void:
	# Move around
	var move_vec = get_movement_vector()
	get_controller().velocity = WALK_SPEED * move_vec
	
	# Save the current direction of motion
	if move_vec.length_squared() > 0.0:
		var left_speed = move_vec.dot( Vector2.LEFT )
		var right_speed = move_vec.dot( Vector2.RIGHT )
		var up_speed = move_vec.dot( Vector2.UP )
		var down_speed = move_vec.dot( Vector2.DOWN )
		var max_speed = max( left_speed, right_speed, up_speed, down_speed )
		
		# Only update if the direction has changed/if prior direction is no longer appropriate
		if (_direction_string == STRING_LEFT and left_speed < max_speed) \
				or (_direction_string == STRING_RIGHT and right_speed < max_speed) \
				or (_direction_string == STRING_UP and up_speed < max_speed) \
				or (_direction_string == STRING_DOWN and down_speed < max_speed):
			# Preferentially pick left/right
			if max_speed == left_speed:
				_direction_string = STRING_LEFT
			elif max_speed == right_speed:
				_direction_string = STRING_RIGHT
			elif max_speed == up_speed:
				_direction_string = STRING_UP
			elif max_speed == down_speed:
				_direction_string = STRING_DOWN

	# Play animations
	if move_vec.length_squared() > 0.0:
		sprite.play( "walk_" + _direction_string )
	
	else:
		sprite.play( "idle_" + _direction_string )
