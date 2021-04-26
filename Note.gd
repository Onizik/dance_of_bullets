extends Area2D

const TARGET_Y_LEFT = 300
const SPAWN_Y_LEFT = 300

const TARGET_X_LEFT = 650
const SPAWN_X_LEFT = -150


const TARGET_Y_DOWN = 526
const SPAWN_Y_DOWN = 1230

const TARGET_X_DOWN = 966
const SPAWN_X_DOWN = 966


const TARGET_Y_RIGHT = 300
const SPAWN_Y_RIGHT = 300

const TARGET_X_RIGHT = 1270
const SPAWN_X_RIGHT = 2070




export var input = ""


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
var lame = "3"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func initialize(lane):
	if lane == 0:
		if Fade.about:
			$AnimatedSprite.play("dasha")
		elif !Fade.scene:
			$AnimatedSprite.play("1")
		elif Fade.bom:
			$AnimatedSprite.play("hl")
		else: $AnimatedSprite.play("bl")
			
		position = LEFT_LANE_SPAWN
		speed = DIST_TO_TARGET_LEFT / time
		left = true
	elif lane == 1:
		if Fade.about:
			$AnimatedSprite.play("evg")
		elif !Fade.scene:
			$AnimatedSprite.play("3")
		elif Fade.bom:
			$AnimatedSprite.play("hl")
		else: $AnimatedSprite.play("2")
		position = CENTRE_LANE_SPAWN
		speed = DIST_TO_TARGET_DOWN / time
		down = true
	elif lane == 2:
		if Fade.about:
			$AnimatedSprite.play("dan")
		elif !Fade.scene:
			$AnimatedSprite.play("4")
		elif Fade.bom:
			$AnimatedSprite.play("hr")
		else: $AnimatedSprite.play("br")
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
		
		


func destroy(lane):
	lame = lane
	if lane =="left":
		if Fade.about:
			$AnimatedSprite.play("dasha")
		elif !Fade.scene:
			$AnimatedSprite.play("1d")
		elif Fade.bom:
			$AnimatedSprite.play("hld")
		else: 
			$AnimatedSprite.play("bld")
	if lane =="up":
		if Fade.about:
			$AnimatedSprite.play("evg")
		elif !Fade.scene:
			$AnimatedSprite.play("3d")
		elif Fade.bom:
			$AnimatedSprite.play("hld")
		else: $AnimatedSprite.play("2d")
	if lane =="right":
		if Fade.about:
			$AnimatedSprite.play("dan")
		elif !Fade.scene:
			$AnimatedSprite.play("4d")
		elif Fade.bom:
			$AnimatedSprite.play("hrd")
		else: $AnimatedSprite.play("brd")
	hit = true
	$Timer.start()

func _on_Timer_timeout():
	
	$AnimatedSprite.visible = false
	queue_free()


func _on_Note_body_entered(body):
	destroy(lame)
