class_name StatePlayerPunchWind
extends StatePlayerPunchBase

var _element: Element = Element.NEUTRAL
var _force_neutral: bool = false
var _timer: float = 0.0
var _timer_running: bool = false


func _start( params: Dictionary = {} ) -> void:
	super._start( params )
	
	_element = params[ "element" ]
	if params.has( "force_neutral" ):
		_force_neutral = params[ "force_neutral" ]
	
	# Play wind-up
	var dir_str = get_direction_string()
	if _element == Element.NEUTRAL:
		animation_player.play( "punch_" + dir_str + "_wind_a" )
	else:
		animation_player.play( "punch_" + dir_str + "_wind_b" )
	
	# Start the timer (could use Godot timers, but we don't want a HARD cutoff)
	_timer = 0.0
	_timer_running = true
	
	# TODO: Ensure metronome is ticking


func _handle_input( event: InputEvent ) -> void:
	# Punch Release
	if ( event.is_action_released( "pl_punch_neutral" ) and _element == Element.NEUTRAL ) or \
			( event.is_action_released( "pl_punch_cyan" ) and _element == Element.CYAN ) or \
			( event.is_action_released( "pl_punch_magenta" ) and _element == Element.MAGENTA ) or \
			( event.is_action_released( "pl_punch_yellow" ) and _element == Element.YELLOW ):
		if _timer > PUNCH_RHYTHM - PUNCH_WIGGLE and \
				_timer < PUNCH_RHYTHM + PUNCH_WIGGLE:
			# If our timing is good, then punch
			change_state( "StatePlayerPunchHit", {
				"element": _element,
				"force_neutral": _force_neutral,
			} )
		else:
			# If the timing is bad, we stumble
			change_state( "StatePlayerStumble" )
	
	# Handle mid-wind-up punch switching
	# Switching fists is a stumble, otherwise update the element and be kind to the player
	if event.is_action_pressed( "pl_punch_neutral" ):
		if _element == Element.NEUTRAL:
			# Weird case, but no correction needed
			pass
		else:
			change_state( "StatePlayerStumble" )
	
	if event.is_action_pressed( "pl_punch_cyan" ):
		if _element == Element.NEUTRAL:
			change_state( "StatePlayerStumble" )
		else:
			_element = Element.CYAN
	
	if event.is_action_pressed( "pl_punch_magenta" ):
		if _element == Element.NEUTRAL:
			change_state( "StatePlayerStumble" )
		else:
			_element = Element.MAGENTA
	
	if event.is_action_pressed( "pl_punch_yellow" ):
		if _element == Element.NEUTRAL:
			change_state( "StatePlayerStumble" )
		else:
			_element = Element.YELLOW


func _update( delta: float ) -> void:
	# Update the timer
	if _timer_running:
		_timer += delta
		
		if _timer > PUNCH_RHYTHM + PUNCH_WIGGLE:
			# If we're too late, Kuro takes damage
			change_state( "StatePlayerHurt" )
