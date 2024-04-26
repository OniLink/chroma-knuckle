class_name State
extends Node

signal state_started( state: String )
signal state_ended( state: String )
signal state_change_requested( state_name: NodePath, params: Dictionary )

var _controller: Node = null


func _ready() -> void:
	pass


func change_state( state_name: NodePath, params: Dictionary = {} ) -> void:
	emit_signal( "state_change_requested", state_name, params )


func get_controller() -> Node:
	return _controller


func start( controller: Node, params: Dictionary = {} ) -> void:
	_controller = controller
	_start( params )
	emit_signal( "state_started", self.name )


func end() -> void:
	_end()
	emit_signal( "state_ended", self.name )


func handle_input( event: InputEvent ) -> void:
	_handle_input( event )


func physics_update( delta: float ) -> void:
	_physics_update( delta )


func update( delta: float ) -> void:
	_update( delta )


func try_transition() -> void:
	_try_transition()


func _start( _params: Dictionary = {} ) -> void:
	pass


func _end() -> void:
	pass


func _handle_input( _event: InputEvent ) -> void:
	pass


func _physics_update( _delta: float ) -> void:
	pass


func _update( _delta: float ) -> void:
	pass


func _try_transition() -> void:
	pass
