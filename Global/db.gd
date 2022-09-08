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

#	Need Bucle that find pokes by id or name

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

func getItem(db, table, key, value):
	var list = db.get(table)
	var item = null
	for i in list:
		if i.get(key) == value:
			item = i
			break
	return item

func getPokeByName(name:String):
	return getItem(pokemons, "pokemons", "name", name)

func getPokeByID(id:int):
	return getItem(pokemons, "pokemons", "id", id)

func addPkm(name:String, desc:String, sound:int, PokmType:String, altura:float, peso:float, 
skills:Array, mt:Array, mo:Array, hideSkill:int, types:Array, status:Array, egg:int, eggCycle:int,
sex:float, evo:Array, areas:Array) -> int:
	var id = (pokemons.get("pokemons")[pokemons.size()-1].get("id"))+1
	if len(types) == 0 or len(types) >= 3:
		printerr("Los tipo de pokemon estan mal definidos\nMinimo: 1\nMaximo: 2\nCantidad Puesta: "+ str(len(types)))
		return 1
	elif len(status) > 7 or len(status) < 6:
		printerr("Los status deben ser 6 o 7 valores enteros\nInsertados: " + str(len(status)))
		return 2
	elif len(evo) != 2 and len(evo) != 0:
		printerr("Debe insertar 0 o 2 valores en la lista de evoluciones\nValue Setted: " + str(evo) + "\tLen: " + str(len(evo)))
		return 3
	if len(evo) != 0:
		if not evo[0] is int or not evo[1] is int:
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
			"sprite": id, #Sprite ID
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
	if GlobalVars.DEBUG:
		print("Added {pkm} to DB".format({"pkm":pkm}))
	return 0

func addPkmWArr(array):
	if len(array) != 18:
		printerr("El array debe contener 18 elementos!!\nTiene: {e}".format({"e":len(array)}))
		return 1
	else:
		var v2 = array[0]
		var v3 = array[1]
		var v4 = array[2]
		var v5 = array[3]
		var v6 = array[4]
		var v7 = array[5]
		var v8 = array[6]
		var v9 = array[7]
		var v10 = array[8]
		var v11 = array[9]
		var v12 = array[10]
		var v13 = array[11]
		var v14 = array[12]
		var v15 = array[13]
		var v16 = array[14]
		var v17 = array[15]
		var v18 = array[16]
		addPkm(v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18)

var sprites = []

func updateSpriteDB():
	if [] == sprites:
		sprites.append(null)
	for i in range(1, 621):
		sprites.append("res://IMGs/Sprites/Pkm/{i}.png".format({"i":i}))
	return 0

func loadFromFile(path:String):
	var file = File.new()
	if not file.file_exists(path):
		printerr("File located in {{path}} NOT EXISTS".format({"path":path}))
		return 1
	else:
		file.open(path, File.READ)
	var text:String = file.get_as_text()
	var lines = text.rsplit("\n")
	#	$Content Content2$ -> Arrays
	#	"Content Content" -> Strings
	var contents = []
	for line in lines:
		var arr:bool = false
		var string:bool = false
		var obj = []
		var subArray = []
		var txt = ""
		for c in line:
			#print("Using char: '{c}' (HEX: {hex})".format({"c": c, "hex":c.to_ascii().hex_encode()}))
			if c == '$':
				arr = !arr
				if !arr:
					if txt != "":
						#print("1. Adding {txt} to subArr".format({"txt": txt}))
						subArray.append(txt)
					obj.append(subArray)
					txt = ""
					subArray = []
				continue
			if c == '"':
				string = !string
				if !string:
					obj.append(txt)
					txt = ""
				continue
			#print("for char '{c}' (HEX: {hex}):\n\t[arr] is {arr}\n\t[str] is {str}\n\t[arr | str] = {is}".format({"c":c, "hex": c.to_ascii().hex_encode(),"arr":arr,"str":string, "is":string or arr}))
			if !(string or arr):
				if c in GlobalVars.SPACE_CHARS:
					if !(string or arr):
						#print("Adding [{txt}] to array".format({"txt": txt}))
						obj.append(txt)
						txt = ""
					else:
						#print("1. adding {c} to txt".format({"c":c}))
						if arr:
							#print("3. Adding {txt} to subArr".format({"txt": txt}))
							subArray.append(txt)
						else:
							txt += c
				else:
					#print("2. adding {c} to txt".format({"c":c}))
					txt += c
			else:
				#print("3. adding {c} to txt".format({"c":c}))
				if arr:
					if c in GlobalVars.SPACE_CHARS:
						#print("4. Adding {txt} to subArr".format({"txt": txt}))
						subArray.append(txt)
						txt = ""
					else:
						txt += c
				else:
					txt += c
		if txt != "":
			obj.append(txt)
		contents.append(obj)
		#print("\nCreating new Array...\n")
	return contents

func loadPokesFromFile(path:String):
	var pokesList = loadFromFile(path)
	if pokesList is int:
		return pokesList
	for p in pokesList:
		addPkmWArr(p)
	return 0

func _ready():
	updateSpriteDB()
	addPkm("Bulbasaur", "Bulbasaur Desc", 8, "plant Pokemon", 7.6, 8.6, [[1, 38], [15, 36]], [], [], 38, [types.planta, types.veneno], [15,16,8,48,6,9], eggs.planta, 80, 16/100, [], [37])
	#print(["Bulbasaur", "Bulbasaur Desc", 8, "plant Pokemon", 7.6, 8.6, [[1, 38], [15, 36]], [], [], 38, [types.planta, types.veneno], [15,16,8,48,6,9], eggs.planta, 80, 16/100, [], [37]])
