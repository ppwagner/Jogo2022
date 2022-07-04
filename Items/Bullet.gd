extends Area2D

export (int) var speed = 10
var direction = Vector2.ZERO
var who = null

func set_direction(vector_direction):
	direction = vector_direction


func _physics_process(_delta):
	if direction != Vector2.ZERO:
		global_position += direction * speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body: Node):
	print(self, ' --> ', body)
	if who != body:
		if body.has_method("took_shoot"):
			body.took_shoot()

		self.queue_free()


func _on_Area2D_area_entered(area: Area2D):
	# print("who: ", area.name)
	if "who" in area and who != area.who:
		area.queue_free()
		queue_free()

