extends State

func _ready():
	id = "state"
	_parent._register_state(self)

func _enter_state() -> void:
	pass
	
func _update_state(delta) -> void:
	pass
	
func _exit_state() -> void:
	pass

func _check_exit_paths()-> void:
	pass
