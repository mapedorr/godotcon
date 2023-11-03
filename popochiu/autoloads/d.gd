@tool
extends "res://addons/popochiu/engine/interfaces/i_dialog.gd"

# classes ----
const PDTalkPopsy := preload('res://popochiu/dialogs/talk_popsy/dialog_talk_popsy.gd')
# ---- classes

# nodes ----
var TalkPopsy: PDTalkPopsy : get = get_TalkPopsy
# ---- nodes

# functions ----
func get_TalkPopsy() -> PDTalkPopsy: return E.get_dialog('TalkPopsy')
# ---- functions

