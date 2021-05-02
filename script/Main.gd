extends Control

func _starter():
	Route.append_page_pos('rumah',$bg/bg_home/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('rumah kaca',$bg/bg_greenhouse/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('kebun belakang',$bg/bg_yard/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('toko',$bg/bg_market/Position2D.get_global_transform_with_canvas().get_origin())
	print(Route.get_page_pos())
	#Global.set_target_position( Global.get_page_name() ) #misal
	
func _ready():
	_starter()
	pass # Replace with function body.

#func _process(delta):
#	$Camera2D.position.x = $Player.position.x
