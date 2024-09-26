extends Node

@onready var label: Label = %Label
@export var hearts: Array[Node]

var souls = 0
var lives = 3

func add_soul():
	souls += 1
	label.text = "Souls: " + str(souls)

func decrease_life():
	lives -= 1
	
	for h in 3:
		if (h < lives):
			hearts[h].show()
		else:
			hearts[h].hide()
	
	if (lives == 0):
		get_tree().reload_current_scene()
