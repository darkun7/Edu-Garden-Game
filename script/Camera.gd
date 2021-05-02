extends Camera2D

var actionState = null setget set_action_state, get_action_state
var pageLim = 3 setget set_page_lim, get_page_lim

func _starter():
	_action_clear()
	_goto_page(0)

func _ready():
	_starter()
	var btnGroups = ['menu_btn','control_btn','action_btn']
	for group in btnGroups:
		for button in get_tree().get_nodes_in_group(group):
			button.connect("pressed", self, "_trigger_signal_press", [[button,group]])
	
	#SAMPLE ACTION BUTTON
	#_action_button([
	#	'Button Primary', 'Button Secondary',
	#], 'select_nursery')
	pass # Replace with function body.

func _trigger_signal_press(data):
	var button = data[0]
	var group = data[1]
	match group:
		"menu_btn":
			match button.name:
				'btn_home':
					_goto_page( Global.set_page(0) )
				'btn_greenhouse':
					_goto_page( Global.set_page(1) )
				'btn_yard':
					_goto_page( Global.set_page(2) )
				'btn_market':
					_goto_page( Global.set_page(3) )
				'btn_more':
					print("more")
				'btn_setting':
					print("setting")
		"control_btn":
			match button.name:
				'ctrl_left':
					_goto_page( Global.get_page()-1 )
				'ctrl_right':
					_goto_page( Global.get_page()+1 )
		"action_btn":
			print('action')
	pass

func _goto_page(pageNum):
	var pageName = Route._page_route(Global.get_scene(),pageNum)
	var action = Route._page_action(pageName)
	#check page limit:
	if(pageNum <= 0):
		$control/ctrl_left.hide()
	else:
		$control/ctrl_left.show()
	if(pageNum >= get_page_lim()):
		$control/ctrl_right.disabled = true
	else:
		$control/ctrl_right.disabled = false
	Global.set_page(pageNum)
	#print(pageName)
	_set_page_name(pageName)
	#Move to position based on name
	Global.set_target_position( pageName )
	_action_button(action[0],action[1])
	return Global.get_page()

func _set_page_name(name):
	$bg_nav_head/PageName.text = name

func _action_button(text, state = "no_action"):
	set_action_state(state)
	$action/btn_primary.hide()
	$action/btn_secondary.hide()
	if( len(text) >= 1 ):
		$action/btn_primary.show()
		$action/btn_primary/text.text = text[0]
		if( len(text) >= 2 ):
			$action/btn_secondary.show()
			$action/btn_secondary/text.text = text[1]
	return get_action_state()

func _action_clear():
	$action/btn_primary.hide()
	$action/btn_secondary.hide()
	set_action_state(null)




### Setter - Getter  ###
func set_action_state(value):
	actionState = value
	return actionState
func get_action_state():
	return actionState

func set_page_lim(value):
	pageLim = value
	return pageLim
func get_page_lim():
	return pageLim
