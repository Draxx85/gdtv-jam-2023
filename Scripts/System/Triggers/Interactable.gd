extends Area3D

@export var data : Resource
@onready var collider : CollisionShape3D = $CollisionShape3D
#@onready var audio_player : AudioStreamPlayer3D = $AudioStreamPlayer3D

var interaction

func _ready():
	if data is InteractableData:
		collider.shape = data.collision_shape
		#audio_player.stream = data.on_use_sound
		if data.on_use != null:
			interaction = data.on_use.new() #will this work?
			interaction.data = data.use_data
	
func use():
	if interaction != null:
#		if is_instance_valid(audio_player):
#			audio_player.play()
		if is_instance_valid(interaction):
			interaction.use()
