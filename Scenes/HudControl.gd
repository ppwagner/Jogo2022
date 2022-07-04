extends CanvasLayer

onready var scoreLabel := $ScoreLabel
onready var hpLabel := $gremio

onready var score := 0
onready var hp := 0

func updateScore() -> void:
	score += 1
	scoreLabel.text = "Score: " + str(score)


func setHP(new_hp: int) -> void:
	print('chave rustica')
	hp = new_hp
	print(hp)
	hpLabel.text = "vida: " + str(hp)


func updateHP() -> void:
	hp -= 1
	hpLabel.draw_texture("cajado.png")
	hpLabel.text = "vida: " + str(hp)
