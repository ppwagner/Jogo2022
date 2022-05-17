extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D

onready var player_bullet_manager = $Player
onready var boss_bullet_manager = $Boss
onready var bullet_manager = $BulletManager

var currentScene = null

func _ready() -> void:
	currentScene = get_child(0)
	sceneLimit = currentScene.get_node("SceneLimit") 
	player = currentScene.get_node("Player")
	player_bullet_manager.connect("player_shooted", bullet_manager, "handle_bullet_spawned")
	boss_bullet_manager.connect("boss_shooted", bullet_manager, "handle_bullet_spawned")
	
func _physics_process(delta: float) -> void:
	if sceneLimit == null:
		return
	if player.position.y > sceneLimit.position.y:
		get_tree().change_scene("res://Scenes/GameOver.tscn")
		
	if Input.is_key_pressed(KEY_X):
		call_deferred("goto_scene", "res://Scenes/GameOver.tscn")
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var effect := AudioServer.get_bus_effect(2, 0)
		var cutoff = effect.get_cutoff()
		if cutoff == 200:
			effect.set_cutoff(20000)
		else:
			effect.set_cutoff(200)
			
func goto_scene(path: String):
	print("Total children: "+str(get_child_count()))
	var world := get_child(0)
	world.free()
	var res := ResourceLoader.load(path)
	currentScene = res.instance()
	sceneLimit = null
	get_tree().get_root().add_child(currentScene)
