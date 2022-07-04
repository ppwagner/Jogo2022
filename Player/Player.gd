extends KinematicBody2D

signal player_shooted(bullet, position, direction, name)

export var hp = 100000000000000000000000
# export var old_hp = 10

export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var velocity = Vector2()
onready var sprite := $SimplePlayer
onready var saida_do_tiro := $SaidaTiro
onready var cajado := $Sprite
onready var cooldown_shoot = $Cooldown_shoot
onready var cooldown_life = $Cooldown_life

var cur_dir = "right"

export (PackedScene) var Bullet

func set_position_staff(direction):
	if direction == "right" and cur_dir == "left":
		cajado.position.x = 36
		cur_dir = "right"
		
	if direction == "left" and cur_dir == "right":
		cajado.position.x = -15
		cur_dir = "left"

#func get_input():
#	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
#	velocity.y = Input.get_action_strength("down")-Input.get_action_strength("up")
#
#	velocity *= run_speed

#	if velocity.x > 0:
#		sprite.play("right")
#		set_position_staff(null, "right")
#		
#	elif velocity.x < 0:
#		sprite.play("left")
#		set_position_staff(null, "left")
#		
#	else:
#		sprite.stop()
#		sprite.frame = 0


func get_input_side():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")

	velocity.x *= run_speed
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed
		# Avisa aos integrantes do grupo "HUD" (no caso, apenas o HudCanvas)
		# que o score deve ser alterado
		#get_tree().call_group("HUD", "updateScore")

	if cooldown_life.is_stopped():
		if velocity.x > 0:
			sprite.play("right")
			set_position_staff("right")

		elif velocity.x < 0:
			sprite.play("left")
			set_position_staff("left")

		else:
			sprite.stop()
			sprite.frame = 0

	else:
		sprite.play("damage")


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		shoot()


func took_shoot():
	if cooldown_life.is_stopped():
		get_tree().call_group("HUD", "updateHP")
		hp -= 1
		if hp == 0:
			queue_free()
		cooldown_life.start()

#func damage_animation():
#	if old_hp != hp:
#		sprite.play("damage")
#		old_hp = hp


func staff_animation():
	if not cooldown_shoot.is_stopped():
		if cur_dir == "right":
			cajado.rotation_degrees = 45

		else:
			cajado.rotation_degrees = 315

	else:
		cajado.rotation_degrees = 0

func shoot():
	if cooldown_shoot.is_stopped():
		# cajado.rotation_degrees = 45
		var bullet_instance = Bullet.instance()
		# add_child(bullet_instance)
		# bullet_instance.global_position = saida_do_tiro.global_position
		var alvo_mouse = get_global_mouse_position()
		var direcao_mouse = saida_do_tiro.global_position.direction_to(alvo_mouse).normalized()
		# bullet_instance.set_direction(direcao_mouse)
		emit_signal("player_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)
		cooldown_shoot.start()


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input_side()
	velocity = move_and_slide(velocity, Vector2.UP)
	staff_animation()
	# damage_animation()
