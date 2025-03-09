extends Node

const TIER := 1
const DESCRIPTION := "Permite executar um dash"

func apply():
	Global.player.can_dash = true
