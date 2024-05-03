class_name StatePlayerNormal
extends StatePlayer

const WALK_SPEED: float = 100.0


func _handle_input( event: InputEvent ) -> void:
	if event.is_action_pressed( "pl_punch_neutral" ):
		change_state( "StatePlayerPunchWind", { "element": Element.NEUTRAL } )
		return
	
	if event.is_action_pressed( "pl_punch_cyan" ):
		change_state( "StatePlayerPunchWind", { "element": Element.CYAN, "force_neutral": true } )
		return
	
	if event.is_action_pressed( "pl_punch_magenta" ):
		change_state( "StatePlayerPunchWind", { "element": Element.MAGENTA, "force_neutral": true } )
		return
	
	if event.is_action_pressed( "pl_punch_yellow" ):
		change_state( "StatePlayerPunchWind", { "element": Element.YELLOW, "force_neutral": true } )
		return


func _update( _dt: float ) -> void:
	# Move around
	var move_vec = get_movement_vector()
	get_controller().velocity = WALK_SPEED * move_vec
	
	# Save the current direction of motion
	update_direction( move_vec )
	
	# Play animations
	if move_vec.length_squared() > 0.0:
		animation_player.play( "walk_" + get_direction_string() )
	else:
		animation_player.play( "idle_" + get_direction_string() )
