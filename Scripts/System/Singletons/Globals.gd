extends Node

func get_direction(vector):
	return int(4.0 * (vector.rotated(PI / 4.0).angle() + PI) / TAU)

signal activate_main_camera()
signal object_entering_camera(object)
signal object_leaving_camera(object)
