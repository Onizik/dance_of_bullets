extends CanvasLayer

signal scene_changed()

onready var animation_player = $AnimationPlayer
onready var black = $Control/ColorRect

var stop = true
var ae = 0

var about = false
var scene = false
var bom = false

func change_scene(path, delay = 0.5):
	yield(get_tree().create_timer(delay), "timeout")
	animation_player.play("New Anim")
	yield(animation_player, "animation_finished")
	assert(get_tree().change_scene(path) == OK)
	animation_player.play_backwards("New Anim")
	emit_signal("scene_changed")

func _ready():
	$AudioStreamPlayer2D.play()
func _physics_process(delta):
	if !stop:
		$AudioStreamPlayer2D.stream_paused = false
	else: $AudioStreamPlayer2D.stream_paused = true
	


func volume (value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),
	linear2db(value))
	ae = value


