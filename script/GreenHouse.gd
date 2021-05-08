extends Control

onready var UI = $Player/Camera2D

var selectedPot setget set_selected_pot, get_selected_pot
var handAction = '' setget set_hand_action, get_hand_action

var toolState = true

func _connect_signal ():
	var btnGroups = ['gh_pot', 'tool_btn']
	for group in btnGroups:
		for button in get_tree().get_nodes_in_group(group):
			button.connect("pressed", self, "_trigger_signal_press", [[button,group]])

func _starter ():
	clear_hand_action()

func _ready():
	_starter()
	UI.refresh()
	$Player/Sprite.hide()
	$Player/Camera2D/action.hide()
	$Player.customSpeed = 5
	Global.set_scene($".".name)        #Set scene just after load
	UI._goto_page(0)     #Set page just after load
	Route.append_page_pos('papan 1',$bg/bg_board1/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 2',$bg/bg_board2/Position2D.get_global_transform_with_canvas().get_origin())
	Route.append_page_pos('papan 3',$bg/bg_board3/Position2D.get_global_transform_with_canvas().get_origin())
	UI.set_page_lim(2)
	_connect_signal()

func _pot_active_pin (potPos):
	var active = $mask_active/pot_active
	var potNode = get_node(potPos)
	#print(potNode.rect_global_position)
	active.rect_position.y = potNode.rect_position.y+395
	active.rect_position.x = potNode.rect_position.x+127
	active.show()
	
func _pot_active_clear():
	var active = $mask_active/pot_active.hide()
	$plant_info.hide()

func _trigger_signal_press (data):
	var button = data[0]
	var group = data[1]
	match group:
		"gh_pot":
			var potId =  button.name.split('_')[1]
			_tool(true)
			if potId != "active":
				var board = "bg_board"+_boardNumber(potId)
				var potPath = "bg/"+board+"/content/"+button.name
				set_selected_pot(potPath)
				if get_hand_action() == '':
					_pot_active_pin(potPath)
					_show_plant_info (potId)
				else:
					print("doAction:",get_hand_action())
					_do_action()
			else:
				_pot_active_clear()
				#Active on click
				pass
		"tool_btn":
			var toolName =  button.name.split('_')[1]
			match toolName:
				"box":
					clear_hand_action()
					_pot_active_clear()
					_toogle_tool()
				"seed":
					set_hand_action("Menanam Benih")
					print("seed")
				"gembor":
					set_hand_action("Menyiram")
					print("gembor")
				"nutrisi":
					set_hand_action("Memberi Nutrisi")
					print("nutrisi")
				"detail":
					print("detail")

func _show_plant_info (id):
	$plant_info.show()

func _do_action ():
	pass

func _boardNumber(id):
	id = int(id)
	if( id >=1 && id <= 9 ):
		return "1"
	if( id >=10 && id <= 18 ):
		return "2"
	if( id >=19 && id <= 28 ):
		return "3"

func _toogle_tool ():
	var contain = $hand/contain
	var tool_seed    = $hand/contain/tool_seed
	var tool_gembor  = $hand/contain/tool_gembor
	var tool_nutrisi = $hand/contain/tool_nutrisi
	var tools = [contain, tool_seed, tool_gembor, tool_nutrisi]
	if toolState:
		for t in tools:
			t.show()
		toolState = !toolState
		$hand/return.hide()
		$plant_info.hide()
	else:
		for t in tools:
			t.hide()
		toolState = !toolState
		if get_hand_action() != '':
			$hand/return.show()
func _tool(state = false):
	if !state:
		toolState = true
		_toogle_tool ()
	else:
		toolState = false
		_toogle_tool ()

### Setter - Getter  ###
# Set pot actives scene name
func set_selected_pot(value):
	selectedPot = value
	return selectedPot
func get_selected_pot():
	return selectedPot

func set_hand_action(value):
	_pot_active_clear()
	handAction = value
	$hand/hand_action.show()
	$hand/action_label.show()
	if value != null or value == '':
		$hand/action_label.text = value
	return handAction
func clear_hand_action():
	$hand/hand_action.hide()
	$hand/action_label.hide()
	handAction = ''
	return handAction
func get_hand_action():
	return handAction
