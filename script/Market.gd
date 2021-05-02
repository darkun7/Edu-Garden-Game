extends Control

func _starter():
	Global.set_scene($".".name)        #Set scene just after load
	$Player/Camera2D._goto_page(0)     #Set page just after load
	Route.append_page_pos('biji',$bg/bg_seed/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('promo cepat',$bg/bg_flashsale/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('peralatan',$bg/bg_tool/Position2D.get_global_transform_with_canvas().get_origin())
	$Player/Camera2D.set_page_lim(2)
	print(Route.get_page_pos())
	
func _ready():
	_starter()
	pass # Replace with function body.

