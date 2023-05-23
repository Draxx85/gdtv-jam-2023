extends Node

class_name IUsable

var data : Resource :
	get:
		return data
	set(value):
		data = value
		_set_data(value)

func use() -> void:
	pass

func _set_data(_value):
	pass
