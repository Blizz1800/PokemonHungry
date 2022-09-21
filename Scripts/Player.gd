extends KinematicBody2D

var pos = Vector2()
export var speed = 50

enum dir {
	up,
	down,
	left,
	right
}

var canMove = true

var look = dir.down
var isStoped = true

func Movement(delta):
	pos = Vector2(0,0)
	if $AnimationPlayer.is_playing() and isStoped:
		if look == dir.down:
			$AnimationPlayer.play("RESET")
		elif look == dir.up:
			$AnimationPlayer.play("Up")
		elif look == dir.right:
			$AnimationPlayer.play("Left")
			$Sprite.flip_h = true
		elif look == dir.left:
			$AnimationPlayer.play("Left")
			$Sprite.flip_h = false
	if Input.is_action_pressed("ui_down"):
		$StickDirection.rotation_degrees = 0
		pos.y += speed * delta
		$AnimationPlayer.play("Front-Walk")
		isStoped = false
		look = dir.down
	elif Input.is_action_pressed("ui_up"):
		$StickDirection.rotation_degrees = 180
		pos.y -= speed * delta
		$AnimationPlayer.play("Back-Walk")
		isStoped = false
		look = dir.up
	elif Input.is_action_pressed("ui_left"):
		$StickDirection.rotation_degrees = 90
		pos.x -= speed * delta
		$Sprite.flip_h = false
		$AnimationPlayer.play("Side-Walk")
		isStoped = false
		look = dir.left
	elif Input.is_action_pressed("ui_right"):
		$StickDirection.rotation_degrees = 270
		pos.x += speed * delta
		$Sprite.flip_h = true
		$AnimationPlayer.play("Side-Walk")
		isStoped = false
		look = dir.right
	else:
		isStoped = true
		pos = Vector2(0,0)
	move_and_collide(pos)

func getTarget():
	return $StickDirection/RayCast2D.get_collider()

func runTarget(Target):
	if Target is KinematicBody2D or Target is StaticBody2D:
		if Target != self and Target.has_signal("Action"):
			if !Target.is_connected("Action", Target, "action"):
				Target.connect("Action", Target, "action", [self])
			Target.emit_signal("Action")

func _ready():
	$StickDirection/RayCast2D.enabled = true

func _physics_process(delta):
	if canMove:
		Movement(delta)
	var target = getTarget()
	if Input.is_action_just_pressed("action"):
		runTarget(target)
