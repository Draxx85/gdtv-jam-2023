class_name StateMachine
extends Node2D

@export var initial_state_path : NodePath

signal state_changed(previous, new)

var active_state : State
var _previous_state : State

var _states = {}

func _ready():
	call_deferred("_set_initial_state")

func _register_state(state : State) -> void:
	_states[state.id] = state
	var _err_code = state.connect("request_state_change",Callable(self,"_on_request_state_change"))
	
func _physics_process(delta) -> void:
	if is_instance_valid(active_state):
		active_state._update_state(delta)
		active_state._check_exit_paths()
		
func _on_request_state_change(old_state: State, new_state: String, forceChange = false):
	if (old_state.id == active_state.id or forceChange):
		if new_state != null && _states.has(new_state):
			active_state._exit_state()
			_previous_state = active_state
			active_state = _states[new_state]
			active_state._enter_state()
			var _err_code = emit_signal("state_changed", old_state, active_state)

func _set_initial_state():
	var state = get_node(initial_state_path)
	active_state = _states[state.id]
	if is_instance_valid(active_state):
		active_state._enter_state()

func go_to_state(state):
	active_state.go_to_state(state)
	
func go_to_previous_state():
	active_state.go_to_state(_previous_state.id)
