class_name StatePlayerPunchBase
extends StatePlayer

const PUNCH_RHYTHM: float = 0.5
const PUNCH_WIGGLE: float = 0.1


func _start( _params : Dictionary = {} ) -> void:
	get_controller().velocity = Vector2.ZERO
