extends Area2D


var velocity = Vector2()
var player : KinematicBody2D = null


func _on_Moeda_body_entered(body):
	if body.name == "Mago":
		get_tree().call_group("HUD", "updateScore")
		queue_free()


func _physics_process(delta):
	velocity.y += gravity * delta
