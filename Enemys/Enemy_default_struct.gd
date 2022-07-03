extends KinematicBody2D

signal boss_shooted(bullet, position, direction, name)

var velocity = Vector2()

var hp = 50
export var gravity = 2500
export (int) var speed = 20

var player = null

var cur_dir = "left"
onready var saida_do_tiro := $SaidaTiro
onready var cooldown_walk = $Cooldown_walk
onready var cooldown_shoot = $Cooldown_shoot

export (PackedScene) var Bullet

func walk():
	if cur_dir == "left":
		velocity.x -= speed

	if cur_dir == "right":
		velocity.x += speed

	if cooldown_walk.is_stopped() and is_on_wall():
		if cur_dir == "left":
			cur_dir = "right"

		else:
			cur_dir = "left"
		
		cooldown_walk.start()

func _ready():
	pass # Replace with function body.


func shoot():
	if cooldown_shoot.is_stopped():
		# cajado.rotation_degrees = 45
		var bullet_instance = Bullet.instance()
		# add_child(bullet_instance)
		# bullet_instance.global_position = saida_do_tiro.global_position
		var alvo_player = player.global_position
		var direcao_mouse = saida_do_tiro.global_position.direction_to(alvo_player).normalized()
		# bullet_instance.set_direction(direcao_mouse)
		emit_signal("enemy_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)
		cooldown_shoot.start()



func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	walk()

