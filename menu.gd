extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Fade.stop = false


func _on_settings_pressed():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 
								linear2db(Fade.ae))
	get_tree().change_scene("res://Scenes/settings.tscn")


func _on_play_pressed():
	

	Fade.change_scene("res://Scenes/story.tscn")



func _on_exit_pressed():
	get_tree().quit()


func _on_about_pressed():
	Fade.about = true
	Fade.change_scene("res://Scenes/maingame.tscn")
