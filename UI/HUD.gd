extends Control

onready var hp = $HealthBar
onready var effect = $HealthBar/Effects

func _ready():
	pass

func _physics_process(_delta):
	update_health()
	update_score()

func update_score():
	#print(Global.score)
	$Score.text = "Score: " + str(Global.score)

func update_health():
	#print(Global.health)
	hp.value = int(Global.health)
	#$Tween.interpolate_property(hp, "value", hp.value, int(Global.health), 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	if hp.value > 6:
		effect.play("Healthy")
	elif hp.value <= 6 and hp.value > 4:
		effect.play("Half")
	elif hp.value <= 4:
		effect.play("Low")
