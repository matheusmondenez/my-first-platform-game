extends Node

const TIER := 1
const DESCRIPTION := "Diminui o intervalo dos disparos em 0.1s"

func apply():
	var node = Global.player.get_node("ShotInterval")
	node.wait_time = 0.1
