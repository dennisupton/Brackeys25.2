extends Control


func _process(_delta: float) -> void:
	if $CenterContainer/VBoxContainer/CheckButton.button_pressed:
		$"../../Speedrun".show()
	if Input.is_action_just_pressed("Esc"):
		if $"../../body".get_child_count()>=2:
			$CenterContainer/VBoxContainer/CenterContainer/Restart.show()
		visible = !visible
		if visible:
			$open.play()
			get_tree().paused = true
			AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1),-35.0,0.4))
		else:
			$close.play()
			get_tree().paused = false
			AudioServer.set_bus_volume_db(1, lerp(AudioServer.get_bus_volume_db(1),0.0,0.4))
	if Input.is_action_just_pressed("Reset") and !visible and $"../../body".get_child_count()>=2:
		var move = Vector2(260,100)-$"../../Snake".position
		$"../../Snake".position = Vector2(260,100)
		for i in $"../../body".get_children():
			i.position += move

func _on_back_pressed() -> void:
	$close.play()
	$click.play()
	visible = !visible
	get_tree().paused = false






func _on_restart_pressed() -> void:
	$click.play()
	var move = Vector2(260,100)-$"../../Snake".position
	$"../../Snake".position = Vector2(260,100)
	for i in $"../../body".get_children():
		i.position += move
	
	visible = !visible
	get_tree().paused = false
