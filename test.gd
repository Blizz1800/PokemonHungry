extends Node
# Declare member variables here. Examples:
# var a = 2
# var b = "text" 



# Called when the node enters the scene tree for the first time.
func _ready():
	var pkm = get_node("/root/PokemonSheet")
	var db = get_node("/root/DB")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
