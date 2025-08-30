extends CharacterBody2D

@export var movementCooldownHold = 150
@export var movementCooldownTap = 5

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var rand = RandomNumberGenerator.new()
var moved = false
var originalPosition = Vector2.ZERO
var nextPosition = Vector2.ZERO
var originalRotation = 0
var nextRotation = 0
var supported = true
var supportedBefore = true
var lastSupported = Vector2.ZERO
var positionChange = Vector2.ZERO
var part = preload("res://part.tscn")
var aura = preload("res://Particles/aura.tscn")
var fall_grass = preload("res://Particles/fall_grass.tscn")
var fall_rock = preload("res://Particles/fall_rock.tscn")
var lastMove = 0
var movedLastFrame = false
var debug = false
var falling = false
var cookiesEaten = 0
var cutsceneIdx = 0
@export var freeze = true
func _physics_process(_delta: float) -> void:
	#$"../Lava".position.y -= 0.4
	if $lavacheck.is_colliding()  and $lavacheck.get_collider() and $lavacheck.get_collider().is_in_group("Lava"):
		get_tree().reload_current_scene()
	if $lavacheck.is_colliding() and $lavacheck.get_collider() and  $lavacheck.get_collider().is_in_group("cookie"):
		$lavacheck.get_collider().queue_free()
		grow(nextPosition,nextRotation)
		$eat.play()
		$Sprite2D/Sprite2D2/cookieParticle.emitting = true
	moved = false
	positionChange = Vector2.ZERO
	originalPosition = global_position
	originalRotation = $Sprite2D.rotation_degrees
	if  Input.is_action_just_pressed("debug"):
		if debug:
			debug = false
		else:
			debug = true
	if (Time.get_ticks_msec()-lastMove > movementCooldownHold and movedLastFrame == true and supported) and !freeze:
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
	elif (Time.get_ticks_msec()-lastMove > movementCooldownTap and supported) and !freeze:
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
			if $groundCheck.get_collider()  and $groundCheck.get_collider().is_in_group("Rock"):
				$move.play()
			else:
				$grass.play()
			position += positionChange
			lastMove = Time.get_ticks_msec()
		else:
			$Sprite2D.rotation_degrees = originalRotation
			moved = false
	if !(Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
		movedLastFrame = false
	#check if supported
	supportedBefore = supported
	supported = false
	$groundCheck.force_raycast_update()

	if $groundCheck.is_colliding() and !$groundCheck.get_collider().is_in_group("cookie") and !$groundCheck.get_collider().is_in_group("Ledge"):
		if !supportedBefore and !falling:
			if float(lastSupported.distance_to(position))/40 > 4:
				$"../Camera2D".shake()
			if $groundCheck.get_collider().is_in_group("Rock"):
				$rockFall.play()
				$fallRock.emitting = true
			else:
				$grassFall.play()
				$fallGrass.emitting = true
		supported = true
		if $groundCheck.get_collider().is_in_group("Fall"):
			$groundCheck.get_collider().hit()
	if falling:
		supported = false
		if global_position.y > 110:
			falling = false
	for i in $"../body".get_child_count():
		$"../body".get_child(i).get_child(1).force_raycast_update()
		if $"../body".get_child(i).get_child(1).is_colliding() and !$"../body".get_child(i).get_child(1).get_collider().is_in_group("cookie") and !$"../body".get_child(i).get_child(1).get_collider().is_in_group("Ledge") and !falling:
			if $"../body".get_child(i).get_child(1).get_collider().is_in_group("Fall"):
				$"../body".get_child(i).get_child(1).get_collider().hit()
			if !supportedBefore and !falling:
				if float(lastSupported.distance_to(position))/40 > 4:
					$"../Camera2D".shake()
				if $"../body".get_child(i).get_child(1).get_collider().is_in_group("Rock"):
					$rockFall.volume_db = -10.0 + float(lastSupported.distance_to(position))/800
					$rockFall.play()
					$"../body".get_child(i).get_child(2).emitting = true
				elif falling:
					$grassFall.volume_db = -10.0 + float(lastSupported.distance_to(position))/800
					$grassFall.play()
					$"../body".get_child(i).get_child(3).emitting = true
			supported = true
	if debug:
		supported = true
	if falling:
		supported = false
		if global_position.y > 110:
			falling = false
	if !supported:
		#position += Vector2(0,10)
		position = lerp(position,position + Vector2(0,40),0.3)
		for i in $"../body".get_children():
			#i.position += Vector2(0,40)
			i.position = lerp(i.position,i.position + Vector2(0,40),0.3)
	else:
		lastSupported = position
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
		var child = aura.instantiate()
		child.position = nextPosition
		$"..".add_child(child)
		$"../body".get_child($"../body".get_child_count()-1).get_child(0).global_rotation_degrees = $"../body".get_child($"../body".get_child_count()-2).get_child(0).global_rotation_degrees
func canMove(pos):
	if debug:
		return false
	for i in $"../body".get_child_count():
		if pos == $"../body".get_child(i).global_position:
			return true
	if $moveCheck.is_colliding() and !$moveCheck.get_collider().is_in_group("Ladder") and !$moveCheck.get_collider().is_in_group("cookie"):
		
		return true
	if $moveCheck.is_colliding() and  $moveCheck.get_collider().is_in_group("cookie"):
		if $moveCheck.get_collider().is_in_group("badCookie"):
			$Timer.start()
		else:
			$moveCheck.get_collider().queue_free()
			grow(nextPosition,nextRotation)
			$eat.play()
			$Sprite2D/Sprite2D2/cookieParticle.emitting = true
		#else:
			#grow(nextPosition,nextRotation)
		
	return false
				


func canMoveUp():
	if debug:
		return true
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
	cookiesEaten += 1
	if (cookiesEaten <= 1):
		return
	var child = part.instantiate()
	child.global_position = $"../body".get_child($"../body".get_child_count()-1).global_position
	child.get_child(0).frame = 4
	$"../body".get_child($"../body".get_child_count()-1).get_child(0).frame = rand.randi_range(12,15)
	$"../body".add_child(child)
	child.global_position = pos
	child.get_child(0).global_rotation_degrees = rot


func _on_timer_timeout() -> void:
	if cutsceneIdx == 0:
		$"../Camera2D".shake()
		freeze = true
		cutsceneIdx = 1
		$"../LedgeAnim/CliffCrumble".play()
		$Timer.start()
	else:
		falling = true
		freeze = false
		$"../Camera2D".shake()
		$"../LedgeAnim".play()
		$"../ParentAnim".play("Rescue")
		$"../Wall2TemporaryWall".add_to_group("Ledge")
