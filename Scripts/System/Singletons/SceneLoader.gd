extends CanvasLayer
class_name SceneLoader
signal scene_changed()

enum transition {none, fade } #should make more


@onready var _overlay : ColorRect = $Control/Overlay
#@onready var _tween  = $Control/Tween

var _is_changing_scene = false

func _ready():
	pass
	
#make this more efficient
func change_scene_to_file(scene, transition_type = transition.fade, delay = 1.0):
	if _is_changing_scene:
		return
	match transition_type:
		transition.fade:
			var tween : Tween
			tween = create_tween()
			_is_changing_scene = true
			_overlay.color.a = 0
			var _discard = tween.tween_property(_overlay, "color:a", 1, delay)
			_discard = tween.tween_callback(_set_scene.bind(scene))
			_discard = tween.tween_property(_overlay, "color:a", 0, delay)
			await tween.finished
			_is_changing_scene = false
			var _err_code = emit_signal("scene_changed")
		transition.none:
			_set_scene(scene)

func _set_scene(scene):
	if scene is PackedScene:
		assert(get_tree().change_scene_to_packed(scene) == OK)
	elif scene is String:
		assert(get_tree().change_scene_to_file(scene) == OK)

func is_changing_scene():
	return _is_changing_scene
