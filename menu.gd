extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	$settings.hide()
	get_tree().change_scene("res://Scenes/girl.tscn")


func _on_settings_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db(Fade.ae))
	get_tree().change_scene("res://Scenes/settings.tscn")


func _on_play_pressed():
	Fade.change_scene("res://Scenes/maingame.tscn")


func _on_exit_pressed():
	get_tree().quit()
