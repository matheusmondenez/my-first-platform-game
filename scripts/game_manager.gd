extends Node

@onready var label: Label = %Label

var souls = 0

func add_soul():
	souls += 1
	label.text = "Souls: " + str(souls)
