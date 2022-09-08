extends Node



func _ready():
	var pkm = get_node("/root/PokemonSheet")
	var db = get_node("/root/DB")
	var s = DB.loadFromFile("res://pk1.txt")
	print(s[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
