extends Area2D

export (int) var speed = 10
var direction = Vector2.ZERO

func set_direction(vector_direction):
	direction = vector_direction


func _physics_process(delta):
	if direction != Vector2.ZERO:
		global_position += direction * speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
