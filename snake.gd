extends CharacterBody2D

@export var movementCooldownHold = 200
@export var movementCooldownTap = 10

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var rand = RandomNumberGenerator.new()
var moved = false
var originalPosition = Vector2.ZERO
var nextPosition = Vector2.ZERO
var originalRotation = 0
var nextRotation = 0
var supported = false
var positionChange = Vector2.ZERO
var part = preload("res://part.tscn")
var lastMove = 0
var movedLastFrame = false

#func _ready():
	
	#grow(global_position - Vector2(40,0),0)
	#grow($"../body".get_child($"../body".get_child_count()-1).global_position - Vector2(40,0),0)

func _physics_process(delta: float) -> void:
	moved = false
	positionChange = Vector2.ZERO
	originalPosition = global_position
	var originalRotation = $Sprite2D.rotation_degrees
	if (Time.get_ticks_msec()-lastMove > movementCooldownHold and movedLastFrame == true and supported):
		if Input.is_action_pressed("ui_up") and canMoveUp():
			positionChange.y -= 40
			$Sprite2D.rotation_degrees = 0
			moved = true
		elif Input.is_action_pressed("ui_down"):
			positionChange.y += 40
			$Sprite2D.rotation_degrees = 180
			moved = true
		elif Input.is_action_pressed("ui_left"):
			positionChange.x -= 40
			$Sprite2D.rotation_degrees = 270
			moved = true
		elif Input.is_action_pressed("ui_right"):
			positionChange.x += 40
			$Sprite2D.rotation_degrees = 90
			moved = true
	elif (Time.get_ticks_msec()-lastMove > movementCooldownTap and supported):
		if Input.is_action_just_pressed("ui_up") and canMoveUp():
			positionChange.y -= 40
			$Sprite2D.rotation_degrees = 0
			moved = true
		elif Input.is_action_just_pressed("ui_down"):
			positionChange.y += 40
			$Sprite2D.rotation_degrees = 180
			moved = true
		elif Input.is_action_just_pressed("ui_left"):
			positionChange.x -= 40
			$Sprite2D.rotation_degrees = 270
			moved = true
		elif Input.is_action_just_pressed("ui_right"):
			positionChange.x += 40
			$Sprite2D.rotation_degrees = 90
			moved = true
	if moved:
		movedLastFrame = true
		$moveCheck.target_position = positionChange
		$moveCheck.force_raycast_update()
		
		if !canMove(position+positionChange):
			position += positionChange
			lastMove = Time.get_ticks_msec()
		else:
			$Sprite2D.rotation_degrees = originalRotation
			moved = false
	if !(Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		movedLastFrame = false
	#check if supported
	supported = false
	$groundCheck.force_raycast_update()
	if $groundCheck.is_colliding():
		supported = true
		if $groundCheck.get_collider() and $groundCheck.get_collider().is_in_group("Fall"):
			$groundCheck.get_collider().hit()
	for i in $"../body".get_child_count():
		$"../body".get_child(i).get_child(1).force_raycast_update()
		if $"../body".get_child(i).get_child(1).is_colliding():
			if $"../body".get_child(i).get_child(1).get_collider().is_in_group("Fall"):
				$"../body".get_child(i).get_child(1).get_collider().hit()
			supported = true
	if !supported:
		#position += Vector2(0,10)
		position = lerp(position,position + Vector2(0,40),0.3)
		for i in $"../body".get_children():
			#i.position += Vector2(0,40)
			i.position = lerp(i.position,i.position + Vector2(0,40),0.3)
	else:
		#position.x = (round((position.x)/40)*40)
		position.y = (round((position.y+20)/40)*40)-20
		for i in $"../body".get_children():
			#i.position += Vector2(0,40)
			#i.position.x = (round((i.position.x)/40)*40)
			i.position.y = (round((i.position.y+20)/40)*40)-20
		
		
	if moved:
		for i in $"../body".get_child_count():
			if i == 0:
				nextPosition = $"../body".get_child(i).global_position
				$"../body".get_child(i).global_position = originalPosition
				nextRotation = $"../body".get_child(i).get_child(0).global_rotation_degrees
				$"../body".get_child(i).get_child(0).global_rotation_degrees = originalRotation
			else:
				originalPosition = nextPosition
				nextPosition = $"../body".get_child(i).global_position
				$"../body".get_child(i).global_position = originalPosition
				originalRotation = nextRotation
				nextRotation = $"../body".get_child(i).get_child(0).global_rotation_degrees
				$"../body".get_child(i).get_child(0).global_rotation_degrees = originalRotation
		$"../body".get_child($"../body".get_child_count()-1).get_child(0).global_rotation_degrees = $"../body".get_child($"../body".get_child_count()-2).get_child(0).global_rotation_degrees
func canMove(pos):
	for i in $"../body".get_child_count():
		if pos == $"../body".get_child(i).global_position:
			return true
	if $moveCheck.is_colliding() and !$moveCheck.get_collider().is_in_group("Ladder") and !$moveCheck.get_collider().is_in_group("cookie"):
		
		return true
	if $moveCheck.is_colliding() and  $moveCheck.get_collider().is_in_group("cookie"):
		$moveCheck.get_collider().queue_free()
		grow(nextPosition,nextRotation)
	return false
				
				
func canMoveUp():
	var straight = true
	var x = global_position.x

	for i in range($"../body".get_child_count()):
		if !$"../body".get_child(i).global_position.x == x:
			straight = false
			i = $"../body".get_child_count()-1
	if straight:
		if $"../body".get_child($"../body".get_child_count()-1).get_child(1).is_colliding():
			for i in range($"../body".get_child_count()-1):
				if $"../body".get_child(i).get_child(1).is_colliding():
					return true
		else:
			return true
		return false
	else:
		return true
func grow(pos,rot):
	var child = part.instantiate()
	child.global_position = $"../body".get_child($"../body".get_child_count()-1).global_position
	child.get_child(0).frame = 4
	$"../body".get_child($"../body".get_child_count()-1).get_child(0).frame = rand.randi_range(12,15)
	$"../body".add_child(child)
	child.global_position = pos
	child.get_child(0).global_rotation_degrees = rot
