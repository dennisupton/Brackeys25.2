extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		visible = !visible
		if visible:
			get_tree().paused = true
			AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1),-35.0,0.4))
		else:
			get_tree().paused = false
			AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1),0.0,0.4))
	if Input.is_action_just_pressed("Reset") and !visible:
		var move = Vector2(260,100)-$"../../Snake".position
		$"../../Snake".position = Vector2(260,100)
		for i in $"../../body".get_children():
			i.position += move

func _on_back_pressed() -> void:
	visible = !visible






func _on_restart_pressed() -> void:
	var move = Vector2(260,100)-$"../../Snake".position
	$"../../Snake".position = Vector2(260,100)
	for i in $"../../body".get_children():
		i.position += move
	
	visible = !visible
