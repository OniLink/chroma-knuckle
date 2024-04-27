class_name StatePlayerNormal
extends StatePlayer

const WALK_SPEED: float = 100.0

@export var sprite: AnimatedSprite2D = null

var _direction_string: String = "down"


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
		
		# Preferentially pick left/right
		if max_speed == left_speed:
			_direction_string = "left"
		elif max_speed == right_speed:
			_direction_string = "right"
		elif max_speed == up_speed:
			_direction_string = "up"
		elif max_speed == down_speed:
			_direction_string = "down"

	# Play animations
	if move_vec.length_squared() > 0.0:
		sprite.play( "walk_" + _direction_string )
	
	else:
		sprite.play( "idle_" + _direction_string )
