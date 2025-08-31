extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = !visible
		if visible:
			$"../..".process_mode = Node.PROCESS_MODE_DISABLED
		else:
			$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE
	if Input.is_action_just_pressed("Reset") and !visible:
		var move = Vector2(300,100)-$"../../Snake".position
		$"../../Snake".position = Vector2(300,100)
		for i in $"../../body".get_children():
			i.position += move

func _on_back_pressed() -> void:
	visible = !visible
	if visible:
		$"../..".process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE





func _on_restart_pressed() -> void:
	var move = Vector2(300,100)-$"../../Snake".position
	$"../../Snake".position = Vector2(300,100)
	for i in $"../../body".get_children():
		i.position += move
	
	visible = !visible
	if visible:
		$"../..".process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$"../..".process_mode = Node.PROCESS_MODE_PAUSABLE
