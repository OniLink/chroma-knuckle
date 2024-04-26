class_name StateMachine
extends Node

signal state_changed( state_name: String )

@export var initial_state := NodePath()

var _state: State = null
var _next_state: State = null
var _is_changing_state: bool = false
var _next_state_params: Dictionary = {}

@onready var _controller: Node = get_parent()


func _ready():
	# Hook up the states
	var candidate_state: State = null
	for state in get_children():
		if not state is State:
			continue
		
		if not candidate_state:
			candidate_state = state
		
		state.connect( "state_change_requested", change_state )
	
	# Select the initial state
	if not has_node( initial_state ) or \
			not ( get_node( initial_state ) is State ):
		initial_state = candidate_state.get_path()

	# Begin
	change_state( initial_state )
	_change_state()


func _unhandled_input( event: InputEvent ) -> void:
	_state.handle_input( event )


func _physics_process( delta: float ) -> void:
	_state.physics_update( delta )


func _process( delta: float ) -> void:
	_state.update( delta )
	_state.try_transition()
	_change_state()


func change_state( new_state: NodePath, params: Dictionary = {} ) -> void:
	var next_state = get_node( new_state )
	if not next_state:
		push_warning( "Invalid state '", new_state, "'" )
		return
	
	_is_changing_state = true
	_next_state = next_state
	_next_state_params = params


func get_controller() -> Node:
	return get_parent()


func _change_state() -> void:
	if not _is_changing_state:
		return
	_is_changing_state = false
	
	if _next_state == null:
		return
	
	if _state:
		_state.end()
	
	_state = _next_state
	_next_state = null
	
	_state.start( _controller, _next_state_params )
	emit_signal( "state_changed", _state.name )
