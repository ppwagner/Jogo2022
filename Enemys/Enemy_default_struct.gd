extends KinematicBody2D

var velocity = Vector2()

var hp = 50
export var gravity = 2500
export (int) var speed = 200

var cur_dir = "left"


func walk():
	if cur_dir == "left":
		velocity.x -= speed

	if cur_dir == "right":
		velocity.x += speed

	if is_on_wall():
		if cur_dir == "left":
			cur_dir = "right"

		else:
			cur_dir = "left"

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	walk()
