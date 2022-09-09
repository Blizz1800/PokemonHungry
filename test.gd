extends Node

func asd():
	print("sss")

func _ready():
	var i = funcref(self, "asd")
	i.call_func()
