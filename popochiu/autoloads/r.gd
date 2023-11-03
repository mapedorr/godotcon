@tool
extends "res://addons/popochiu/engine/interfaces/i_room.gd"

# classes ----
const PRHouse := preload('res://popochiu/rooms/house/room_house.gd')
const PROutside := preload('res://popochiu/rooms/outside/room_outside.gd')
const PREnd := preload('res://popochiu/rooms/end/room_end.gd')
# ---- classes

# nodes ----
var House: PRHouse : get = get_House
var Outside: PROutside : get = get_Outside
var End: PREnd : get = get_End
# ---- nodes

# functions ----
func get_House() -> PRHouse: return super.get_runtime_room('House')
func get_Outside() -> PROutside: return super.get_runtime_room('Outside')
func get_End() -> PREnd: return super.get_runtime_room('End')
# ---- functions

