extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_right") and $a1.visible:
		$f2.visible = true 
		$a2.visible = true
	elif Input.is_action_pressed("ui_down") and $a2.visible:
		$f3.visible = true 
		$f3/line.visible = true
		$a3.visible = true
	elif Input.is_action_pressed("ui_left") and $a3.visible:
		$f4.visible = true 
		$a3.visible = true
		Fade.change_scene("res://Scenes/maingame.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
