extends PopochiuPopup


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _open() -> void:
	E.current_command = SierraCommands.Commands.INTERACT


func _close() -> void:
	if I.active:
		Cursor.set_secondary_cursor_texture(I.active.texture)
	else:
		Cursor.show_cursor(E.get_current_command_name(true))


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _on_look_pressed() -> void:
	if is_instance_valid(I.active):
		I.active = null
	
	E.current_command = SierraCommands.Commands.LOOK
	
	# Force changing the cursor passing `true` as second parameter
	Cursor.show_cursor(E.get_current_command_name(true), true)


func _on_select_pressed() -> void:
	if is_instance_valid(I.active):
		I.active = null
	
	E.current_command = SierraCommands.Commands.INTERACT
	
	Cursor.show_cursor("use", true)
