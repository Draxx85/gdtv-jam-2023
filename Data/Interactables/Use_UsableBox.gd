extends IUsable

@export var material : Material

func use() -> void:
	material.albedo_color = Color(1 , 0, 0, 1)

func _set_data(value):
	material = value.material
