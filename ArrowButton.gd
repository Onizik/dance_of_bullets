extends AnimatedSprite
var hit = 1
export var input = ""
var current_note = null



func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input, false):
			if current_note != null:
				if hit ==2:
					current_note.destroy(input)
				_reset()


		if event.is_action_pressed(input):
			frame = 1
		elif event.is_action_released(input):
			$PushTimer.start()
			
func _on_Area_area_entered(area):
	if area.is_in_group("note"):
		hit = 2
		current_note = area


func _on_Area_area_exited(area):
	if area.is_in_group("note"):
		hit = 3
		current_note = null
		


func _reset():
	current_note = null
	hit = 1



func _on_PushTimer_timeout():
	frame = 0
