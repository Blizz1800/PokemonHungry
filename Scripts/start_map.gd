extends Node2D

func _ready():
	#print("Started")
	if GlobalVars.mapPlayerStartPos != -1:
		var pos = get_node(str(GlobalVars.mapPlayerStartPos))
		$Player.position = pos.position
	else:
		var pos = get_node(str(1))
		$Player.position = pos.position
