extends Node2D


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
var stage = false
var hp = 5

func _ready():
	Fade.stop = true
	randomize()
	stage = Fade.scene
	if Fade.about:
		$Conductor.stream = load ("res://Assets/song/credits.ogg")
		bpm = 100
		sec_per_beat = 100.0 / bpm
		
		$logo.visible = true
		$dan.visible = true
		$evg.visible = true
		$dasha.visible = true
	else:
		if !stage:
			$Conductor.stream = load ("res://Assets/song/first.ogg")
			$bg.frame = 0
		if stage:
			$Conductor.stream = load ("res://Assets/song/boss.ogg")
			$bg.frame = 1
	$Conductor.play_with_beat_offset(8)
	#$Conductor.play_from_beat(152,8)
	$bg/Sprite2/AnimationPlayer.play("default")


func _input(event):
	if event.is_action("escape"):
		Fade.about = false
		Fade.scene = false
		Fade.bom = false
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
	if hp<0:
		Fade.change_scene("res://Scenes/Death.tscn")
		Fade.scene = false
		Fade.about = false
		Fade.bom = false
	elif hp==4:
		$torch.play("4")
	elif hp==3:
		$torch.play("3")
	elif hp==2:
		$torch.play("2")
	elif hp==1:
		$torch.play("1")
	elif hp==0:
		$torch.play("0")

	song_position_in_beats = position
	if song_position_in_beats > 36:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 40 and Fade.about:
		$thank/AnimationPlayer.play("New Anim")
	if song_position_in_beats > 40:
		spawn_1_beat = 1
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 44 and Fade.about:
		Fade.about = false
		Fade.change_scene("res://Scenes/menu.tscn")
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
	if song_position_in_beats == 152 and !Fade.scene:
		Fade.change_scene("res://Scenes/maingame.tscn")
		Fade.scene =true

	if song_position_in_beats > 152:
		spawn_1_beat = 0
		spawn_2_beat = 1
		spawn_3_beat = 0
		spawn_4_beat = 2

	if song_position_in_beats == 168:
		storm()
		$hand.visible = true
		$booby.visible = true

	if song_position_in_beats > 192:
		spawn_1_beat = 2
		spawn_2_beat = 0
		spawn_3_beat = 1
		spawn_4_beat = 0
	if song_position_in_beats == 268:
		Fade.change_scene("res://Scenes/win.tscn")

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
	hp-=1
	anim = true


func _on_Timer_timeout():

		$girl.play("idle")



func _on_KinematicBody2D_input_event(viewport, event, shape_idx):
	$girl.play("miss")
	
	anim = true


func _on_Conductor_finished():
	pass

onready var animation_player = $AnimationPlayer
onready var black = $Control/ColorRect


func storm():
	#yield(get_tree().create_timer(0.3), "timeout")
	animation_player.play("storm")
	yield(animation_player, "animation_finished")
	$bg.frame = 2
	animation_player.play_backwards("storm")
	Fade.bom = true


func _on_Button_pressed():
	pass
