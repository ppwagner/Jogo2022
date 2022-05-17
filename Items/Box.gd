extends Area2D

onready var tween := $Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$AnimationPlayer.play("scale")
	tween.interpolate_property(self, "scale", Vector2(1,1), Vector2(1.5,1.5), 1)
	tween.interpolate_property(self, "scale",
	 Vector2(1.5,1.5),
	 Vector2(1,1), 1,
	Tween.TRANS_ELASTIC,
	Tween.EASE_OUT,1)
	tween.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_VisibilityNotifier2D_screen_exited() -> void:
	print("Saiu!")
	queue_free()
