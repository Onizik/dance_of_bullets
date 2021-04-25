extends Node2D

var score = 0
var combo = 0

var max_combo = 0
var great = 0
var good = 0
var okay = 0
var missed = 0

var bpm = 120

var song_position = 0.0
var song_position_in_beats = 0
var last_spawned_beat = 0
var sec_per_beat = 120.0 / bpm

var spawn_1_beat = 0
var spawn_2_beat = 0
var spawn_3_beat = 1
var spawn_4_beat = 0

var lane = 0
var rand = 0
var note = load("res://Scenes/Note.tscn")
var instance
var anim = false

func _ready():
	randomize()
	$Conductor.play_with_beat_offset(8)
	#$Conductor.play_from_beat(100,8)
	$bg/Sprite2/AnimationPlayer.play("default")


func _input(event):
	if event.is_action("escape"):
		if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
			print ("Error changing scene to Menu")


func _on_Conductor_measure(position):
	if position == 1:
		_spawn_notes(spawn_1_beat)
	elif position == 2:
		_spawn_notes(spawn_2_beat)
	elif position == 3:
		_spawn_notes(spawn_3_beat)
	elif position == 4:
		_spawn_notes(spawn_4_beat)

func _on_Conductor_beat(position):
	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 52:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats > 98:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 2
		spawn_4_beat = 0
	if song_position_in_beats > 152:
		$girl.hide()
		





		if get_tree().change_scene("res://Scenes/End.tscn") != OK:
			print ("Error changing scene to End")



func _spawn_notes(to_spawn):
	if to_spawn > 0:
		lane = randi() % 3
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
	if to_spawn > 1:
		while rand == lane:
			rand = randi() % 3
		lane = rand
		instance = note.instance()
		instance.initialize(lane)
		add_child(instance)
		

func _process(delta):
	if Input.is_action_pressed("left"):
		$girl.play ("left")
		anim = true
	if Input.is_action_pressed("right"):
		$girl.play ("right")
		anim = true
	if Input.is_action_pressed("up"):
		$girl.play ("down")
		anim = true
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		$girl.play ("lr")
		anim = true
	if Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		$girl.play ("ld")
		anim = true
	if Input.is_action_pressed("up") and Input.is_action_pressed("right"):
		$girl.play ("rd")
		anim = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	
	$girl.play("miss")
	anim = true


func _on_Timer_timeout():

		$girl.play("idle")



func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	$girl.play("miss")
	anim = true
