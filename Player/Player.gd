extends KinematicBody2D

signal player_shooted(bullet, position, direction, name)

export var hp = 10
export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2()
onready var sprite := $SimplePlayer
onready var saida_do_tiro := $SaidaTiro
onready var cajado := $Sprite

export (PackedScene) var Bullet

func set_position_staff(current_position, direction):
	if direction == "right":
		pass
		
	if direction == "left":
		pass

func get_input():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down")-Input.get_action_strength("up")

	velocity *= run_speed

	if velocity.x > 0:
		sprite.play("right")
		
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0


func get_input_side():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")

	velocity.x *= run_speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		# Avisa aos integrantes do grupo "HUD" (no caso, apenas o HudCanvas)
		# que o score deve ser alterado		
		get_tree().call_group("HUD", "updateScore")
	
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		cajado.rotation_degrees = 45
		shoot()
		# cajado.rotation_degrees = 0


func took_shoot():
	get_tree().call_group("HUD", "updateHP")
	hp -= 1
	if hp == 0:
		queue_free()


func shoot():
	var bullet_instance = Bullet.instance()
	# add_child(bullet_instance)
	# bullet_instance.global_position = saida_do_tiro.global_position
	var alvo_mouse = get_global_mouse_position()
	var direcao_mouse = saida_do_tiro.global_position.direction_to(alvo_mouse).normalized()
	# bullet_instance.set_direction(direcao_mouse)
	emit_signal("player_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)
	
func _physics_process(delta):
	velocity.y += gravity * delta
	get_input_side()
	velocity = move_and_slide(velocity, Vector2.UP)
