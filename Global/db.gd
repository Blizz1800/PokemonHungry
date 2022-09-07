extends Node
enum types{
	normal,
	fuego,
	lucha,
	agua,
	volador,
	planta,
	veneno,
	electrico,
	tierra,
	psiquico,
	roca,
	hielo,
	bicho,
	dragon,
	fantasma,
	siniestro,
	acero,
	hada
}

enum foodType{
	carne, 
	hongo, 
	pescado, 
	ballas, 
	frutas
}

var pokemons = {
	"pokemons": 
	[
		{
			"id": 0, #Pkm ID
			"sprite": 0, #Sprite ID
			"name": "Unknown", #Pkm Name
			"desc": "", # Pokemon Desc
			"sound": 0,
			"pkmType": "", # Tipo pokemon o Identificador ej: Pikachu -> "raton electrico"
			"altura": 0,
			"peso": 0, 
			"skills": [
				{"lvl": 0, "skill": 0}
			], #level, skill que aprende
			"mt":[], #MTs que aprende
			"mo":[], #MOs que aprende
			"hideSkill": 0, # Hide Skill ID
			"types": [], # pkm types MAX: 2
			"status": [0,0,0,0,0,0,0],  # [PS, ATQ, DEF, A. Esp, D. Esp, Vel, Total]
			"huevo": 0,  #Tipo de Huevo
			"eggCycle": 0,  #Pasos o minutos necesarios para eclosionar el juego
			"sex": 0,  #Porcentaje para posibilidad de sexo masculino
			"evolution": [null, null],  #[INT, INT] -> [Level, Evolution]
			"area": []  #INTs Values refering to the zones
		}
	]
}

enum eggs {
	amorfo,
	humano,
	desconocido,
	agua1,
	agua2,
	agua3,
	bicho,
	campo,
	mineral,
	planta,
	monstruo,
	dragon,
	hada,
	vuelo,
	ditto
}

var sprites = [
	{"id": 0, "path": "res://187.png"}
]

func addPkm(SpriteID:int, name:String, desc:String, sound:int, PokmType:String, altura:float, peso:float, 
skills:Array, mt:Array, mo:Array, hideSkill:int, types:Array, status:Array, egg:int, eggCycle:int,
sex:float, evo:Array, areas:Array) -> int:
	var id = pokemons.get("pokemons")[pokemons.size()-1].get("id")+1
	if len(types) == 0 or len(types) >= 3:
		printerr("Los tipo de pokemon estan mal definidos\nMinimo: 1\nMaximo: 2\nCantidad Puesta: "+ str(len(types)))
		return 1
	elif len(status) > 7 or len(status) < 6:
		printerr("Los status deben ser 6 o 7 valores enteros\nInsertados: " + str(len(status)))
		return 2
	elif len(evo) != 2 and not (evo == null):
		printerr("Debe insertar 2 valores en la lista de evoluciones o dejarlo \"null\"\nValue Setted: " + str(evo))
		return 3
	elif not evo[0] is int or not evo[1] is int:
		printerr("El los valores de evo deben ser enteros solamente\nEvo Values: "+ str(evo))
		return 4
		
	if len(status) == 6:
		var total = 0
		var count = 0
		for i in status:
			if not i is int:
				printerr("The value at " + str(count) + " is not INTEGER \tValue: " + str(i))
				return 5
			total += i
			count += 1
		status.append(total)
	else: 
		var total = 0
		var count = 0
		for i in status:
			if count == 6:
				break
			if not i is int:
				printerr("The value at " + str(count) + " is not INTEGER \tValue: " + str(i))
				return 5
			total += i
			count += 1
		status[6] = total
	var pkm = {
			"id": id, #Pkm ID
			"sprite": SpriteID, #Sprite ID
			"name": name, #Pkm Name
			"desc": desc, # Pokemon Desc
			"sound": sound,
			"pkmType": PokmType, # Tipo pokemon o Identificador ej: Pikachu -> "raton electrico"
			"altura": altura,
			"peso": peso, 
			"skills": skills, #level, skill que aprende
			"mt": mt, #MTs que aprende
			"mo": mo, #MOs que aprende
			"hideSkill": hideSkill, # Hide Skill ID
			"types": types, # pkm types MAX: 2
			"status": status,  # [PS, ATQ, DEF, A. Esp, D. Esp, Vel, Total]
			"huevo": egg,  #Tipo de Huevo
			"eggCycle": eggCycle,  #Pasos o minutos necesarios para eclosionar el juego
			"sex": sex,  #Porcentaje para posibilidad de sexo masculino
			"evolution": evo,  #[INT, INT] -> [Level, Evolution]
			"area": areas  #INTs Values refering to the zones
		}
	pokemons.get("pokemons").append(pkm)
	return 0

func _ready():
	pass
	
	
