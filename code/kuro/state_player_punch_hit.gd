class_name StatePlayerPunchHit
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
		animation_player.play( "punch_" + dir_str + "_release_a" )
	else:
		animation_player.play( "punch_" + dir_str + "_release_b" )
	
	# Start the timer (could use Godot timers, but we don't want a HARD cutoff)
	_timer = 0.0
	_timer_running = true
	
	# TODO: Ensure metronome is ticking


func _handle_input( event: InputEvent ) -> void:
	# Select the next punch element
	var next_element: Element = Element.NEUTRAL
	var is_punching: bool = false
	if event.is_action_pressed( "pl_punch_neutral" ):
		next_element = Element.NEUTRAL
		is_punching = true
	
	if event.is_action_pressed( "pl_punch_cyan" ):
		next_element = Element.CYAN
		is_punching = true
	
	if event.is_action_pressed( "pl_punch_magenta" ):
		next_element = Element.MAGENTA
		is_punching = true
	
	if event.is_action_pressed( "pl_punch_yellow" ):
		next_element = Element.YELLOW
		is_punching = true
	
	# Force neutral if double-element
	var force_neutral = ( _element != Element.NEUTRAL and next_element != Element.NEUTRAL )
	
	# Initiate the next punch wind-up on the timer
	if is_punching:
		if _timer > PUNCH_RHYTHM - PUNCH_WIGGLE and \
				_timer < PUNCH_RHYTHM + PUNCH_WIGGLE:
			change_state( "StatePlayerPunchWind", {
				"element": next_element,
				"force_neutral": force_neutral,
			} )
		elif _timer < PUNCH_RHYTHM:
			change_state( "StatePlayerStumble" )
		elif _timer > PUNCH_RHYTHM:
			change_state( "StatePlayerNormal" )


func _update( delta: float ) -> void:
	# Update the timer
	if _timer_running:
		_timer += delta
		
		if _timer > PUNCH_RHYTHM + PUNCH_WIGGLE:
			# If we're too late, Kuro exits combat stance
			change_state( "StatePlayerNormal" )
