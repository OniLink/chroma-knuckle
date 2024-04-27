class_name StatePlayer
extends State


func get_movement_vector() -> Vector2:
	return Input.get_vector( "pl_left", "pl_right", "pl_up", "pl_down" )
