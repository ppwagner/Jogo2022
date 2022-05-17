extends CanvasLayer

onready var scoreLabel := $ScoreLabel
onready var score := 0

func updateScore() -> void:	
	score += 1
	scoreLabel.text = "Score: " + str(score)
	
