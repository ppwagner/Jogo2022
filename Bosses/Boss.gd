extends KinematicBody2D

signal boss_shooted(bullet, position, direction)

var velocity = Vector2()
var dir_tiro = Vector2()
var rotation_dir = 0

export var gravity = 2500
export (int) var speed = 200
export (float) var rotation_speed = 1.5
onready var saida_do_tiro := $SaidaTiro

export (PackedScene) var Bullet

func shoot():
	var bullet_instance = Bullet.instance()
	var direcao_mouse = saida_do_tiro.global_position.direction_to(dir_tiro).normalized()
	emit_signal("boss_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse)
	dir_tiro = Vector2(speed, 0).rotated(rotation_dir)



func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	rotation_dir += 0.1

	# (rotation_dir)
	
	shoot()
