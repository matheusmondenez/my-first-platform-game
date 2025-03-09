extends Node

const TIER := 1
const DESCRIPTION := "Aumenta a velocidade de movimento em 50%"

func apply():
	Global.player.speed *= 1.5
