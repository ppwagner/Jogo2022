extends CanvasLayer

onready var scoreLabel := $ScoreLabel
onready var hpLabel := $gremio
onready var notify := $notify
onready var show_time := $Cooldown_notify
onready var death_notify := $RichTextLabel
onready var win_notify := $RichTextLabel2

onready var hp := 0
onready var score := 0

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
	hpLabel.text = "vida: " + str(hp)


func _ready():
	notify.text = "FASE 1"
	win_notify.visible = false
	death_notify.visible = false


func setNotify(new_text: String) -> void:
	notify.text = new_text
	notify.visible = true
	show_time.start()


func death_trigger():
	death_notify.visible = true


func win_trigger():
	win_notify.visible = true


func _on_Cooldown_notify_timeout():
	notify.visible = false
