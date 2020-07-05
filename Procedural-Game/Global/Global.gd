extends Node2D

const BOMB := preload("res://Bomb/Bomb.tscn")
const EXPLOSION := preload("res://Bomb/Explosion.tscn")

var Rooms = [ 
	{ 
		"room" : preload("res://Rooms/Room1.tscn"),
		"group": "r"
	},
	{ 
		"room" : preload("res://Rooms/Room2.tscn"),
		"group": "lr"
	},
	{ 
		"room" : preload("res://Rooms/Room3.tscn"),
		"group": "ld"
	},
	{ 
		"room" : preload("res://Rooms/Room4.tscn"),
		"group": "lu"
	},
	{ 
		"room" : preload("res://Rooms/Room5.tscn"),
		"group": "lr"
	},
	{ 
		"room" : preload("res://Rooms/Room6.tscn"),
		"group": "rd"
	},
	{ 
		"room" : preload("res://Rooms/Room7.tscn"),
		"group": "ru"
	},
	{ 
		"room" : preload("res://Rooms/Room8.tscn"),
		"group": "lr"
	},
	{ 
		"room" : preload("res://Rooms/Room9.tscn"),
		"group": "l"
	}
	]
