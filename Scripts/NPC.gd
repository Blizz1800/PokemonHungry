extends Node2D

var ID = randi()
export (String) var Name
export (Array, String) var dialog:Array = []
export (bool) var Trainer 
export (Array, PackedScene) var pokes = []
export (Texture) var sprite

var tPokes = []
var PlayerWin = false

var DialogFlow = preload("res://Tools/DialogFlow.tscn")

var interact = true

var player = null

var i = 0
var finish = false

func destroy():
	for i in GlobalVars.sceneNPCs:
		if i.get('id') == self.ID:
			GlobalVars.sceneNPCs.erase(i)
			
			GlobalVars.sceneNPCs.append(
				{
					"id": i.get("id"),
					"npc": i.get('npc'),
					"active": false
				}
			)
			break
	self.queue_free()

func _ready():
	$NPC_SP.texture = self.sprite
	add_user_signal("Action")
	player = get_tree().get_nodes_in_group("player")[0]
	if !get_parent().has_node("Canvas/DialogFlow") and get_parent().has_node("Canvas"):
		get_parent().add_child(DialogFlow.instance())
	if Trainer:
		self.add_to_group("trainer")
		for poke in pokes:
			var vars = poke._bundled.get('variants')
			var p = []
			for i in vars:
				if typeof(i) == typeof(GDScript):
					continue
				else:
					p.append(i)
			if len(p) == 0:
				continue
			tPokes.append(p)
	for i in GlobalVars.sceneNPCs:
		if i.get('id') == self.ID:
			
			self.ID = randi()
	GlobalVars.sceneNPCs.append(
		{
			"id": self.ID,
			"npc": self,
			"active": true
		}
	)
	get_parent().get_node("Canvas/DialogFlow/AnimationPlayer").play("Continue")

func battle():
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept") and len(dialog) > 0 and interact:
		action(player)
	if Trainer and $RayCast2D.is_colliding():
		var body = $RayCast2D.get_collider()
		if get_tree().get_nodes_in_group("player")[0] == body:
			action(body)

func action(player):
	print("Running")
	self.player = player
	player.canMove = false
	interact = true
	if $Tween.is_active():
		if get_parent().get_node("Canvas/DialogFlow/Panel/Text").percent_visible < 1:
			$Tween.stop_all()
			get_parent().get_node("Canvas/DialogFlow/Panel/Text").percent_visible = 1
			return
	if len(dialog) > 0 and !finish:
		get_parent().get_node("Canvas/DialogFlow").visible = true
		get_parent().get_node("Canvas/DialogFlow/Panel/Text").percent_visible = 0
		get_parent().get_node("Canvas/DialogFlow/Panel/Text").text = "{1}: {2}".format({'1': Name, '2':dialog[i]})
		$Tween.interpolate_property(get_parent().get_node("Canvas/DialogFlow/Panel/Text"), "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		if i == len(dialog)-1:
			finish = true
			interact = false
			get_parent().get_node("Canvas/DialogFlow/AnimationPlayer").play("stoped")
		else:
			i+=1
	else:
		get_parent().get_node("Canvas/DialogFlow").visible = false
		player.canMove = true
		finish = false 
		i = 0
		if Trainer:
			if battle() and !PlayerWin:
				PlayerWin = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if(!finish):
		get_parent().get_node("Canvas/DialogFlow/AnimationPlayer").play("Continue")
	else:
		get_parent().get_node("Canvas/DialogFlow/AnimationPlayer").play("stoped")
