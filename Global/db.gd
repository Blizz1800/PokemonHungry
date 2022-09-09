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

var db = {
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
			"pasiveSkill": [0,0,0,0],
			"hideSkill": 0, # Hide Skill ID
			"types": [], # pkm types MAX: 2
			"status": [0,0,0,0,0,0,0],  # [PS, ATQ, DEF, A. Esp, D. Esp, Vel, Total]
			"huevo": 0,  #Tipo de Huevo
			"eggCycle": 0,  #Pasos o minutos necesarios para eclosionar el juego
			"sex": 0,  #Porcentaje para posibilidad de sexo masculino
			"evolution": [null, null],  #[INT, INT] -> [Level, Evolution]
			"area": []  #INTs Values refering to the zones
		}
	],
	"skills":
	[
		{
			"id":0,
			"name": "",  #Nombre de la habilidad
			"desc": "",  #Descripcion de la habilidad
			"type": 0,  #Tipo de ataque (Igual que el tipo de pokemon)
			"dps": 0,  #Daño que inflije (si cura es el cuanto cura)
			"precision": 0.0,  #Probabilidad de acierto
			"pp": 0.0,  #PP que consume
			"afecta":0,  #0 Para el usuario, -1 aliado (Usuario tambien), -2 (solo aliado), 0< Enemigos (1 o +)
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

func getItem(table, key, value):
	var list = db.get(table)
	var item = null
	for i in list:
		if i.get(key) == value:
			item = i
			break
	return item


func getPokeByName(name:String):
	return getItem("pokemons", "name", name)

func getPokeByID(id:int):
	return getItem("pokemons", "id", id)

func addSkill(name:String, desc:String, type:int, dps:int, precision:float, pp:float, afecta:int):
	var id = (db.get("skills")[db.get("skills").size()-1].get("id"))+1
	var obj = {
			"id":id,
			"name": name,  #Nombre de la habilidad
			"desc": desc,  #Descripcion de la habilidad
			"type": type,  #Tipo de ataque (Igual que el tipo de pokemon)
			"dps": dps,  #Daño que inflije (si cura es el cuanto cura)
			"precision": precision,  #Probabilidad de acierto
			"pp": pp,  #PP que consume
			"afecta": afecta,  #0 Para el usuario, -1 aliado (Usuario tambien), -2 (solo aliado), 0< Enemigos (1 o +)
		}
	db.get("skills").append(obj)

func addPkm(name:String, desc:String, PokmType:String, altura:float, peso:float, 
skills:Array, mt:Array, mo:Array, pasiveSkill:Array, hideSkill:int, types:Array, status:Array, egg:int, eggCycle:int,
sex:float, evo:Array, areas:Array) -> int:
	var id = (db.get("pokemons")[db.get("pokemons").size()-1].get("id"))+1
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
	var fSkills = []
	for s in skills:
		fSkills.append({"lvl":s[0], "skill":[1]})
	var pkm = {
			"id": id, #Pkm ID
			"sprite": id, #Sprite ID
			"name": name, #Pkm Name
			"desc": desc, # Pokemon Desc
			"sound": id,
			"pkmType": PokmType, # Tipo pokemon o Identificador ej: Pikachu -> "raton electrico"
			"altura": altura,
			"peso": peso, 
			"skills": fSkills, #level, skill que aprende
			"mt": mt, #MTs que aprende
			"mo": mo, #MOs que aprende
			"pasiveSkill": pasiveSkill,
			"hideSkill": hideSkill, # Hide Skill ID
			"types": types, # pkm types MAX: 2
			"status": status,  # [PS, ATQ, DEF, A. Esp, D. Esp, Vel, Total]
			"huevo": egg,  #Tipo de Huevo
			"eggCycle": eggCycle,  #Pasos o minutos necesarios para eclosionar el juego
			"sex": sex,  #Porcentaje para posibilidad de sexo masculino
			"evolution": evo,  #[INT, INT] -> [Level, Evolution]
			"area": areas  #INTs Values refering to the zones
		}
	db.get("pokemons").append(pkm)
	if GlobalVars.DEBUG:
		print("Added {pkm} to DB".format({"pkm":pkm}))
	return 0

func addPkmWArr(array):
	if len(array) != 17:
		printerr("El array debe contener 17 elementos!!\nTiene: {e}".format({"e":len(array)}))
		return 1
	else:
		var v1 = array[0]
		var v2 = array[1]
		var v3 = array[2]
		var v4 = array[3]
		var v5 = array[4]
		var v6 = array[5]
		var v7 = array[6]
		var v8 = array[7]
		var v9 = array[8]
		var v10 = array[9]
		var v11 = array[10]
		var v12 = array[11]
		var v13 = array[12]
		var v14 = array[13]
		var v15 = array[14]
		var v16 = array[15]
		var v17 = array[16]
		#var v18 = array[17]
		print(array)
		addPkm(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17)

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
	#	$Content Content2% -> Arrays
	#	"Content Content" -> Strings
	var contents = []
	for line in lines:
		var arr:bool = false
		var string:bool = false
		var obj = []
		var subArray = []
		var lenSub = -1
		var subs = 0
		var txt = ""
		for c in line:
			#print("Using char: '{c}' (HEX: {hex})".format({"c": c, "hex":c.to_ascii().hex_encode()}))
			if c == '$':
				arr = true
				lenSub +=1
				#print("2. LenSub +1 ({l})".format({"l":lenSub}))
				if lenSub > 0:
					subs += 1
					subArray.append([])
				continue
			elif c == '%':
				#print("1. "+str(subArray))
				#print("1. LenSub +1 ({l})".format({"l":lenSub}))
				if lenSub > 0:
					if txt != "": 
						#print("1. Adding {txt} to subArr".format({"txt": txt}))
						var tmp = subs
						while tmp != 0:
							for i in range(0, len(subArray)):
								#print("subArr[{i}]: \t".format({"i":i})+str(subArray[i] is Array))
								#print(str(subArray[i])+"\t"+str(i))
								if subArray[i] is Array:
									if tmp > 0:
										tmp -= 1
									if tmp == 0:
										#print("SA[{i}] is {s}".format({"i": i, "s": subArray[i]}))
										#print("{txt} -> subArray".format({"txt":txt}))
										if not txt in GlobalVars.SPACE_CHARS and txt != "":
											subArray[i].append(GlobalVars.returnNum(txt))
										txt = ""
										break
				else:
					arr == false
					if not txt in GlobalVars.SPACE_CHARS and txt != "":
						subArray.append(GlobalVars.returnNum(txt))
					obj.append(subArray)
					arr = false
					string = false
					#obj = []
					subArray = []
					lenSub = -1
					subs = 0
					txt = ""
				lenSub-=1
				continue
			if c == '"':
				string = !string
				if !string:
					obj.append(GlobalVars.returnNum(txt))
					arr = false
					string = false
					#obj = []
					subArray = []
					lenSub = -1
					subs = 0
					txt = ""
				continue
			#print("for char '{c}' (HEX: {hex}):\n\t[arr] is {arr}\n\t[str] is {str}\n\t[arr | str] = {is}".format({"c":c, "hex": c.to_ascii().hex_encode(),"arr":arr,"str":string, "is":string or arr}))
			if !(string or arr):
				if c in GlobalVars.SPACE_CHARS:
					if !(string or arr):
						#print("Adding [{txt}] to array".format({"txt": txt}))
						if txt in GlobalVars.SPACE_CHARS:
							obj.append(GlobalVars.returnNum(txt))
							arr = false
							string = false
							#obj = []
							subArray = []
							lenSub = -1
							subs = 0
							txt = ""
						elif txt != "":
							obj.append(GlobalVars.returnNum(txt))
							arr = false
							string = false
							#obj = []
							subArray = []
							lenSub = -1
							subs = 0
							txt = ""
					else:
						#print("1. adding {c} to txt".format({"c":c}))
						if arr:
							#print("3. Adding {txt} to subArr".format({"txt": txt}))
							if not txt in GlobalVars.SPACE_CHARS:
								subArray.append(GlobalVars.returnNum(txt))
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
						if lenSub > 0:
							var tmp = subs
							if txt != "":
								while tmp != 0:
									for i in range(0, len(subArray)):
									#print("subArr[{i}]: \t".format({"i":i})+str(subArray[i] is Array))
									#print(str(subArray[i])+"\t"+str(i))
										if subArray[i] is Array:
											if tmp > 0:
												tmp -= 1
											if tmp == 0:
												#print("SA[{i}] is {s}".format({"i": i, "s": subArray[i]}))
												#print("2. {txt} -> subArray".format({"txt":txt}))
												if not txt in GlobalVars.SPACE_CHARS and txt != "":
													subArray[i].append(GlobalVars.returnNum(txt))
												txt = ""
												break
						else:
							if not txt in GlobalVars.SPACE_CHARS and txt != "":
								subArray.append(GlobalVars.returnNum(txt))
						txt = ""
					else:
						txt += c
				else:
					txt += c
		if txt != "":
			obj.append(GlobalVars.returnNum(txt))
			arr = false
			string = false
			#obj = []
			subArray = []
			lenSub = -1
			subs = 0
			txt = ""
		if obj == []:
			continue
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
	#addPkm("Bulbasaur", "Bulbasaur Desc", 8, "plant Pokemon", 7.6, 8.6, [[1, 38], [15, 36]], [], [], [5], 38, [types.planta, types.veneno], [15,16,8,48,6,9], eggs.planta, 80, 16/100, [], [37])
	#print(["Bulbasaur", "Bulbasaur Desc", 8, "plant Pokemon", 7.6, 8.6, [[1, 38], [15, 36]], [], [], 38, [types.planta, types.veneno], [15,16,8,48,6,9], eggs.planta, 80, 16/100, [], [37]])
