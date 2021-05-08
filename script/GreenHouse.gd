extends Control

var selectedPot setget set_selected_pot, get_selected_pot

func _connect_signal():
	var btnGroups = ['gh_pot']
	for group in btnGroups:
		for button in get_tree().get_nodes_in_group(group):
			button.connect("pressed", self, "_trigger_signal_press", [[button,group]])

func _ready():
	$Player/Sprite.hide()
	$Player.customSpeed = 5
	Global.set_scene($".".name)        #Set scene just after load
	$Player/Camera2D._goto_page(0)     #Set page just after load
	Route.append_page_pos('papan 1',$bg/bg_board1/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 2',$bg/bg_board2/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 3',$bg/bg_board3/Position2D.get_global_transform_with_canvas().get_origin())
	$Player/Camera2D.set_page_lim(2)
	print(Route.get_page_pos())
	_connect_signal()

func _pot_active_pin (potPos):
	var active = $mask_active/pot_active
	var potNode = get_node(potPos)
	print(potNode.rect_global_position)
	active.rect_position.y = potNode.rect_position.y+253
	active.rect_position.x = potNode.rect_position.x+140
	active.show()
	
func _pot_active_clear():
	var active = $mask_active/pot_active.hide()

func _trigger_signal_press (data):
	var button = data[0]
	var group = data[1]
	match group:
		"gh_pot":
			var potId =  button.name.split('_')[1]
			if potId != "active":
				var board = "bg_board"+_boardNumber(potId)
				var potPath = "bg/"+board+"/content/"+button.name
				set_selected_pot(potPath)
				_pot_active_pin(potPath)
			else:
				_pot_active_clear()
				#Active on click
				pass

func _boardNumber(id):
	id = int(id)
	if( id >=1 && id <= 9 ):
		return "1"
	if( id >=10 && id <= 18 ):
		return "2"
	if( id >=19 && id <= 28 ):
		return "3"

### Setter - Getter  ###
# Set pot actives scene name
func set_selected_pot(value):
	selectedPot = value
	return selectedPot
func get_selected_pot():
	return selectedPot
