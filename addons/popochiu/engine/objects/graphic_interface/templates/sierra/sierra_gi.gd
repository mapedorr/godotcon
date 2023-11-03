extends PopochiuGraphicInterface


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	super()
	
	Cursor.replace_frames($Cursor)
	Cursor.show_cursor()
	
	$Cursor.hide()
	
	$Menu.hide()
	
	E.current_command = SierraCommands.Commands.WALK
	
	%SierraSettingsPopup.option_selected.connect(_on_settings_option_selected)


func _input(event: InputEvent) -> void:
	if D.current_dialog: return
	
	if event is InputEventMouseMotion:
		if get_global_mouse_position().y < 16.0:
			# Show the top menu
			if not I.active:
				Cursor.show_cursor("gui")
			
			$Menu.show()
		elif get_global_mouse_position().y > $Menu.size.y and $Menu.visible:
			# Hide the top menu
			if not I.active:
				Cursor.show_cursor(E.get_current_command_name(true))
			
			$Menu.hide()
	elif event is InputEventMouseButton and event.is_pressed():
		match (event as InputEventMouseButton).button_index:
			MOUSE_BUTTON_LEFT:
				if not $Menu.visible and not E.hovered\
				 and E.current_command != SierraCommands.Commands.WALK:
					get_viewport().set_input_as_handled()
			MOUSE_BUTTON_RIGHT:
				get_viewport().set_input_as_handled()
				
				E.current_command = posmod(
					E.current_command + 1, SierraCommands.Commands.size()
				)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ VIRTUAL ░░░░
func _on_blocked(props := { blocking = true }) -> void:
	set_process_input(false)


func _on_unblocked() -> void:
	set_process_input(true)


func _on_mouse_entered_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	if not I.active:
		G.show_hover_text(clickable.description)
	else:
		G.show_hover_text(
			'Use %s with %s' % [I.active.description, clickable.description]
		)


func _on_mouse_exited_clickable(clickable: PopochiuClickable) -> void:
	if G.is_blocked: return
	
	G.show_hover_text()


func _on_dialog_line_started() -> void:
	Cursor.hide()


func _on_dialog_line_finished() -> void:
	Cursor.show()


func _on_dialog_started(_dialog: PopochiuDialog) -> void:
	Cursor.show_cursor("gui")


func _on_dialog_finished(_dialog: PopochiuDialog) -> void:
	Cursor.show_cursor(E.get_current_command_name(true))


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _on_inventory_pressed() -> void:
	%SierraInventoryPopup.open()
	$Menu.hide()


func _on_settings_pressed() -> void:
	%SierraSettingsPopup.open()


func _on_settings_option_selected(option_name: String) -> void:
	match option_name:
		"sound":
			%SierraSoundPopup.open()
		"text":
			%SierraTextPopup.open()
		"save":
			%SaveAndLoadPopup.open_save()
		"load":
			%SaveAndLoadPopup.open_load()
		"quit":
			_on_quit_pressed()


func _on_quit_pressed() -> void:
	%QuitPopup.open()
