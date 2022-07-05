extends Area2D


func _on_Bau_body_entered(body):
	if body.name == "Mago":
		body.hp = 0
		get_tree().call_group("HUD", "setHP", 0)
		get_tree().call_group("HUD", "win_trigger")
