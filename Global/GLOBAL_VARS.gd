extends Node

const DEBUG = false
const SPACE_CHARS = [' ', '\v', '\t', '\r', '\v', '\f']

var INT_CHARS = []
var ALFA_CHARS = []

var mapPlayerStartPos:int = -1

const DOT = char(46)

var sceneNPCs = []

func _ready():
	for c in range(48,57):
		INT_CHARS.append(char(c))
	for c in range(33, 45):
		ALFA_CHARS.append(char(c))
	ALFA_CHARS.append(char(47))
	for c in range(58, 126):
		ALFA_CHARS.append(char(c))

func returnNum(txt:String):
	for c in ALFA_CHARS:
		if c in txt:
			return txt
	if DOT in txt:
		return float(txt)
	return int(txt)

func waitForInput(InputString):
	while(!Input.is_action_just_pressed(InputString)):
		pass
	return true
