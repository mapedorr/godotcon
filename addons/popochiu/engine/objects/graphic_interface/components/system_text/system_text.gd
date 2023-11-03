extends RichTextLabel
## Show a text in the form of GUI. Can be used to show game (or narrator)
## messages.
# ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
# warning-ignore-all:unused_signal
# warning-ignore-all:return_value_discarded

signal shown

const DFLT_SIZE := 'dflt_size'


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ GODOT ░░░░
func _ready() -> void:
	set_meta(DFLT_SIZE, size)
	
	# Connect to singletons signals
	G.system_text_shown.connect(_show_text)
	
	close()


func _draw() -> void:
	position = get_parent().size / 2.0 - size / 2.0


func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton or not visible:
		return
	
	var e: InputEventMouseButton = event
	
	get_viewport().set_input_as_handled()
	
	if e.is_pressed() and e.button_index == MOUSE_BUTTON_LEFT:
		close()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PULBIC ░░░░
func appear() -> void:
	show()
	set_process_input(true)


func close() -> void:
	set_process_input(false)
	
	clear()
	text = ""
	size = get_meta(DFLT_SIZE)
	
	hide()
	G.system_text_hidden.emit()


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ PRIVATE ░░░░
func _show_text(msg := '') -> void:
	clear()
	text = ""
	size = get_meta(DFLT_SIZE)
	append_text('[center]%s[/center]' % msg)
	
	if msg:
		appear()
	else:
		close()
