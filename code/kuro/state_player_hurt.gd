class_name StatePlayerHurt
extends StatePlayer

# TODO: THIS


func _start( params: Dictionary = {} ) -> void:
	super._start( params )
	change_state( "StatePlayerNormal" )
