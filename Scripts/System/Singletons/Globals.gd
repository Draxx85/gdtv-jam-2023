extends Node2D

func get_direction(vector):
	return int(4.0 * (vector.rotated(PI / 4.0).angle() + PI) / TAU)
