extends Area2D

const TARGET_Y_LEFT = 400
const SPAWN_Y_LEFT = 400

const TARGET_X_LEFT = 710
const SPAWN_X_LEFT = -150


const TARGET_Y_DOWN = 516
const SPAWN_Y_DOWN = 1230

const TARGET_X_DOWN = 966
const SPAWN_X_DOWN = 966


const TARGET_Y_RIGHT = 400
const SPAWN_Y_RIGHT = 400

const TARGET_X_RIGHT = 1210
const SPAWN_X_RIGHT = 2070







const DIST_TO_TARGET_LEFT = TARGET_X_LEFT - SPAWN_X_LEFT
const DIST_TO_TARGET_DOWN= SPAWN_Y_DOWN - TARGET_Y_DOWN
const DIST_TO_TARGET_RIGHT = SPAWN_X_RIGHT - TARGET_X_RIGHT

const LEFT_LANE_SPAWN = Vector2(SPAWN_X_LEFT, SPAWN_Y_LEFT)
const CENTRE_LANE_SPAWN = Vector2(SPAWN_X_DOWN, SPAWN_Y_DOWN)
const RIGHT_LANE_SPAWN = Vector2(SPAWN_X_RIGHT, SPAWN_Y_RIGHT)

var speed = 0
var hit = false
var left = false
var down = false
var right = false
var time = 2.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(lane):
	if lane == 0:
		$AnimatedSprite.play("1")
		position = LEFT_LANE_SPAWN
		speed = DIST_TO_TARGET_LEFT / time
		left = true
	elif lane == 1:
		$AnimatedSprite.play("3")
		position = CENTRE_LANE_SPAWN
		speed = DIST_TO_TARGET_DOWN / time
		down = true
	elif lane == 2:
		$AnimatedSprite.play("4")
		position = RIGHT_LANE_SPAWN
		speed = DIST_TO_TARGET_RIGHT / time
		right = true
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if !hit:
		if left:
			position.x += speed*delta
		if right:
			position.x -= speed*delta
		if down:
			position.y -=speed*delta
	else:
		if left:
			$Node2D.position.x -= speed*delta
		if right:
			$Node2D.position.x += speed*delta
		if down:
			$Node2D.position.y +=speed*delta
		
		


func destroy():
	$AnimatedSprite.visible = false
	hit = true
	$Timer.start()

func _on_Timer_timeout():
	queue_free()


func _on_Note_body_entered(body):
	destroy()
