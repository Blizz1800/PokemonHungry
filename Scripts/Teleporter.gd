extends Node2D

export (String) var Scene:String
export (int) var Position

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bodies = $Area2D.get_overlapping_bodies()
	if len(bodies) != 0:
		for body in bodies:
			if body is TileMap:
				continue
			elif body.is_in_group("player"):
				
				Scene = Scene.to_lower()
				GlobalVars.mapPlayerStartPos = Position
				get_tree().change_scene("res://Scenarios/"+Scene+".tscn")
