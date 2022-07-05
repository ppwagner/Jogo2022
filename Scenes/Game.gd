extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D

onready var player_bullet_manager = $Mago
onready var boss_bullet_manager = $Boss
onready var bullet_manager = $BulletManager

onready var teste = $HudCanvas


func _ready() -> void:
	player = get_child(0)
	player_bullet_manager.connect("player_shooted", bullet_manager, "handle_bullet_spawned")
	boss_bullet_manager.connect("boss_shooted", bullet_manager, "handle_bullet_spawned")

	teste.setHP(player.hp)

func _physics_process(_delta: float) -> void:
	if sceneLimit == null:
		return
