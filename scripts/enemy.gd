extends RigidBody2D

@onready var game_manager: Node = %GameManager

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		
		if (y_delta > -250):
			queue_free()
			body.jump()
		else:
			game_manager.decrease_life()
			
			if (x_delta >= 168 and x_delta < 270):
				print("vai pra trás", x_delta)
			elif (x_delta >= 270):
				print("vai pra frente", x_delta)
