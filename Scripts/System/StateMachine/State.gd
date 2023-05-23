extends Node

class_name State

signal request_state_change(source, new_state)

#@warning_ignore(unused_private_class_variable)
@onready var _parent = get_parent()

var _state_paths = {}
var id : String

func _enter_state():
	pass
	
func _update_state(_delta):
	pass
	
func _exit_state():
	pass

func _check_exit_paths():
	pass

func go_to_state(state):
	var _err_code = emit_signal("request_state_change", self, state )
