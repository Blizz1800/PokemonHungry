extends Node



func _ready():
	var pkm = get_node("/root/PokemonSheet")
	var db = get_node("/root/DB")
	#var s = DB.loadPokesFromFile("res://pk1.txt")
	print("\nTypes: "+str(DB.types)+"\nEggs: "+str(DB.eggs)+"\nFood: "+str(DB.foodType))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
