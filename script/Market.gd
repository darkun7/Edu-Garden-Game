extends Control

onready var UI = $Player/Camera2D

func _starter():
	UI.showCurrency = true
	UI.showEXP = true
	UI.refresh()
	Global.set_scene($".".name)        #Set scene just after load
	UI._goto_page(0)     #Set page just after load
	Route.append_page_pos('benih',$bg/bg_seed/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('promo cepat',$bg/bg_flashsale/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('peralatan',$bg/bg_tool/Position2D.get_global_transform_with_canvas().get_origin())
	UI.set_page_lim(2)
	print(Route.get_page_pos())
	
func _ready():
	_starter()
	pass # Replace with function body.

