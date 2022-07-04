extends Node2D

var sceneLimit : Position2D
var player : KinematicBody2D

onready var player_bullet_manager = $Mago
onready var boss_bullet_manager = $Boss
onready var bullet_manager = $BulletManager
# onready var archer1_bullet_manager = $Archer1_inicio_dir_inf


onready var teste = $HudCanvas

# var currentScene = null

func _ready() -> void:
	player = get_child(0)
	# print("archer game", archer1_bullet_manager)
	# sceneLimit = currentScene.get_node("SceneLimit")
	# player = currentScene.get_node("Player")
	player_bullet_manager.connect("player_shooted", bullet_manager, "handle_bullet_spawned")
	boss_bullet_manager.connect("boss_shooted", bullet_manager, "handle_bullet_spawned")
	# archer1_bullet_manager.connect("enemy_shooted", bullet_manager, "handle_bullet_spawned")

	teste.setHP(player.hp)

func _physics_process(_delta: float) -> void:
	if sceneLimit == null:
		return
	
#func _input(event: InputEvent) -> void:
#	if event.is_action_pressed("pause"):
#		var effect := AudioServer.get_bus_effect(2, 0)
#		var cutoff = effect.get_cutoff()
#		if cutoff == 200:
#			effect.set_cutoff(20000)
#		else:
#			effect.set_cutoff(200)
#			
#func goto_scene(path: String):
	#print("Total children: "+str(get_child_count()))
	#var world := get_child(0)
	#world.free()
	#var res := ResourceLoader.load(path)
	#currentScene = res.instance()
	#sceneLimit = null
	#get_tree().get_root().add_child(currentScene)
