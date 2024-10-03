extends Node

var game_camera: GameCamera = null
var clients: Array[Tank] = []

var	no_console := true

var player_color: Color:
	set(value):
		clients[0].tank_color = value
		clients[0].core_sprite.modulate = value
		clients[0].get_node("TankTrail").update_color()
		player_color = value

const CORE_REQUIREMENT = {
	1: 1,
	2: 500,
	3: 2000,
	4: 8000,
	5: 25000,
}

var PRELOADS = {
	"energy-square": load("res://scenes/containers/energy-square.tscn"),
	"energy-triangle": load("res://scenes/containers/energy-triangle.tscn"),
	"energy-pentagon": load("res://scenes/containers/energy-pentagon.tscn"),
	"energy-octagon": load("res://scenes/containers/energy-octagon.tscn"),
}
