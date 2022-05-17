extends Node2D

var total : float = 0

func _ready() -> void:
	update_score(total)

func _process(delta: float) -> void:
	print(delta)
	total += delta
	update_score(total)
	if Input.is_action_pressed("left"):
		$Score.rect_position.x -= 100 * delta
	elif Input.is_action_pressed("right"):
		$Score.rect_position.x += 100 * delta
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("left"):
#		$Score.rect_position.x -= 10
#	elif event.is_action_pressed("right"):
#		$Score.rect_position.x += 10
#	
func update_score(current_score: float) -> void:
	$Score.text = str(current_score)
	
func _on_Timer_timeout() -> void:
	pass
	#$Score.visible = !$Score.visible
