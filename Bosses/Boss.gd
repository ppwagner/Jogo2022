extends KinematicBody2D

signal boss_shooted(bullet, position, direction, name)

var velocity = Vector2()
var dir_tiro = Vector2()

var rotation_dir = 0
onready var rng = RandomNumberGenerator.new().randomize()

enum State {
	 ROTATION_SHOOT,
	 RAIN_SHOOT
}

var hp = 50
export var gravity = 2500
export (int) var speed = 200
export (float) var rotation_speed = 1.5

onready var saida_do_tiro := $SaidaTiro

onready var saida_rain1 := $Rain_shoot1
onready var saida_rain2 := $Rain_shoot2
onready var saida_rain3 := $Rain_shoot3
onready var saida_rain4 := $Rain_shoot4

onready var rain_list = [saida_rain1, saida_rain2, saida_rain3, saida_rain4]

export (PackedScene) var Bullet
export (PackedScene) var RainBullet

func shoot():
	var bullet_instance = Bullet.instance()
	var direcao_mouse = saida_do_tiro.position.direction_to(dir_tiro).normalized()
	emit_signal("boss_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)
	dir_tiro = Vector2(speed, 0).rotated(rotation_dir)


func rain_shoot():
	for tiro in rain_list:
		var rain_bullet_instance = RainBullet.instance()
		emit_signal("boss_shooted", rain_bullet_instance, tiro.global_position, Vector2.DOWN, self)


func _on_Timer_timeout():
	var num = randi() % State.size()
	if num == 0: #ROTATION_SHOOT
		for _i in range(20):
			shoot()
			rotation_dir += 36

	elif num == 1: #RAIN_SHOOT
		rain_shoot()


func took_shoot():
	hp -= 1
	if hp == 0:
		queue_free()


func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_Timer_timeout")


func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	rotation_dir += 0.1

