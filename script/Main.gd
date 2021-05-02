extends Control

func _starter():
	Global.set_scene($".".name)        #Set scene just after load
	$Player/Camera2D._goto_page(0)     #Set page just after load
	Route.append_page_pos('rumah',$bg/bg_home/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('rumah kaca',$bg/bg_greenhouse/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('kebun belakang',$bg/bg_yard/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('toko',$bg/bg_market/Position2D.get_global_transform_with_canvas().get_origin())
	$Player/Camera2D.set_page_lim(3)
	print(Route.get_page_pos())
	
func _ready():
	_starter()
	pass # Replace with function body.

