extends State

func _ready():
	id = "state"
	_parent._register_state(self)

func _enter_state():
	pass
	
func _update_state(delta):
	pass
	
func _exit_state():
	pass

func _check_exit_paths():
	pass
