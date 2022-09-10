extends KinematicBody2D

var pos = Vector2()
export var Speed = 2
var vSpeed = 0
var hSpeed = 0

func Movement(delta):
	if Input.is_action_pressed("Player_Move_D"):
		pass
	elif Input.is_action_pressed("Player_Move_U"):
		pass
	else:
		pass
	if Input.is_action_pressed("Player_Move_L"):
		pass
	elif Input.is_action_pressed("Player_Move_R"):
		pass
	else:
		pass
		

func _ready():
	pass

func _physics_process(delta):
	Movement(delta)
