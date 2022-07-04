extends KinematicBody2D

signal enemy_shooted(bullet, position, direction, name)

var velocity = Vector2()

var hp = 3
var start_hp = hp

export var gravity = 2500
export (int) var speed = 7

var player : KinematicBody2D = null

var cur_dir = "left"
onready var saida_do_tiro := $SaidaTiro
onready var cooldown_walk = $Cooldown_walk
onready var cooldown_shoot = $Cooldown_shoot

onready var moedas := preload("res://Items/Moeda.tscn")
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


func _on_Cooldown_shoot_timeout():
	if player != null:
		shoot()


func _ready():
	self.connect("enemy_shooted", owner.get_child(1), "handle_bullet_spawned")


func shoot():
	var bullet_instance = Bullet.instance()
	var alvo_player = player.global_position
	var direcao_mouse = saida_do_tiro.global_position.direction_to(alvo_player).normalized()
	emit_signal("enemy_shooted", bullet_instance, saida_do_tiro.global_position, direcao_mouse, self)


func took_shoot():
	hp -= 1
	if hp == 0:
		for i in range(start_hp):
			var new_moeda := moedas.instance()
			new_moeda.position = saida_do_tiro.global_position + Vector2(i*5, 0)
			owner.add_child(new_moeda)

		queue_free()


func _physics_process(delta):
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if player == null:
		walk()


func _on_Area2D_body_entered(body):
	if body.name == "Mago" and player == null:
		player = body

