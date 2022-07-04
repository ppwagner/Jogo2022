extends Area2D


var player : KinematicBody2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Moeda_body_entered(body):
	if body.name == "Mago":
		get_tree().call_group("HUD", "updateScore")
		queue_free()
