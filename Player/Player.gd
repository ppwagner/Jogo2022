extends KinematicBody2D

signal player_shooted(bullet, position, direction, name)

export var hp = 30

export var run_speed = 350
export var jump_speed = -1000
export var gravity = 2500

var alive := true
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


func get_input_side():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")

	velocity.x *= run_speed
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_speed


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
		if hp > 0:
			hp -= 1
			get_tree().call_group("HUD", "updateHP")

		if hp == 0:
			alive = false
			get_tree().call_group("HUD", "death_trigger")

		cooldown_life.start()


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
		var bullet_instance = Bullet.instance()
		var alvo_mouse = get_global_mouse_position()
		var direcao_mouse = saida_do_tiro.global_position.direction_to(alvo_mouse).normalized()
		emit_signal("player_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)
		cooldown_shoot.start()


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input_side()
	if alive == true:
		velocity = move_and_slide(velocity, Vector2.UP)
	staff_animation()
