@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIIKey := preload('res://popochiu/inventory_items/key/item_key.gd')
const PIIHook := preload('res://popochiu/inventory_items/hook/item_hook.gd')
const PIIApple := preload('res://popochiu/inventory_items/apple/item_apple.gd')
# ---- classes

# nodes ----
var Key: PIIKey : get = get_Key
var Hook: PIIHook : get = get_Hook
var Apple: PIIApple : get = get_Apple
# ---- nodes

# functions ----
func get_Key() -> PIIKey: return super.get_item_instance('Key')
func get_Hook() -> PIIHook: return super.get_item_instance('Hook')
func get_Apple() -> PIIApple: return super.get_item_instance('Apple')
# ---- functions

