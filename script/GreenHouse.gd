extends Control

func _ready():
	$Player/Sprite.hide()
	Global.set_scene($".".name)        #Set scene just after load
	$Player/Camera2D._goto_page(0)     #Set page just after load
	Route.append_page_pos('papan 1',$bg/bg_board1/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 2',$bg/bg_board2/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 3',$bg/bg_board3/Position2D.get_global_transform_with_canvas().get_origin())
	$Player/Camera2D.set_page_lim(2)
	print(Route.get_page_pos())
