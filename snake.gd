extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var moved = false
var originalPosition = Vector2.ZERO
var nextPosition = Vector2.ZERO
var supported = false
var positionChange = Vector2.ZERO
var part = preload("res://part.tscn")
func _physics_process(delta: float) -> void:
	moved = false
	positionChange = Vector2.ZERO
	originalPosition = global_position
	if Input.is_action_just_pressed("ui_up"):
		positionChange.y -= 40
		moved = true
	elif Input.is_action_just_pressed("ui_down"):
		positionChange.y += 40
		moved = true
	elif Input.is_action_just_pressed("ui_left"):
		positionChange.x -= 40
		moved = true
	elif Input.is_action_just_pressed("ui_right"):
		positionChange.x += 40
		moved = true
	if moved:
		$moveCheck.target_position = positionChange
		$moveCheck.force_raycast_update()
		
		if !canMove(position+positionChange):
			position += positionChange
		else:
			moved = false
			
	#check if supported
	supported = false
	if $groundCheck.is_colliding():
		supported = true
	for i in $"../body".get_child_count():
		if $"../body".get_child(i).get_child(1).is_colliding():
			if $"../body".get_child(i).get_child(1).get_collider().is_in_group("Fall"):
				$"../body".get_child(i).get_child(1).get_collider().hit()
			supported = true
	if !supported:
		position += Vector2(0,40)
		for i in $"../body".get_children():
			i.position += Vector2(0,40)
		
		
		
		
	if moved:
		for i in $"../body".get_child_count():
			if i == 0:
				nextPosition = $"../body".get_child(i).global_position
				$"../body".get_child(i).global_position = originalPosition
			else:
				originalPosition = nextPosition
				nextPosition = $"../body".get_child(i).global_position
				$"../body".get_child(i).global_position = originalPosition

		
func canMove(pos):
	for i in $"../body".get_child_count():
		if pos == $"../body".get_child(i).global_position:
			return true
	if $moveCheck.is_colliding() and !$moveCheck.get_collider().is_in_group("Ladder") and !$moveCheck.get_collider().is_in_group("cookie"):
		
		return true
	if $moveCheck.is_colliding() and  $moveCheck.get_collider().is_in_group("cookie"):
		$moveCheck.get_collider().queue_free()
		var child = part.instantiate()
		child.global_position = $"../body".get_child($"../body".get_child_count()-1).global_position
		$"../body".add_child(child)
	return false
				
				

				
