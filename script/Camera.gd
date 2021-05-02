extends Camera2D

var actionState = null setget set_action_state, get_action_state
var pageLim = 3 setget set_page_lim, get_page_lim

func _starter():
	_action_clear()
	_play_transition()

func _ready():
	_starter()
	var btnGroups = ['menu_btn','control_btn','action_btn']
	for group in btnGroups:
		for button in get_tree().get_nodes_in_group(group):
			button.connect("pressed", self, "_trigger_signal_press", [[button,group]])
	pass # Replace with function body.
	if( Global.get_change_scene().has('page') ):
		_goto_page( Global.set_page( Global.get_change_scene()['page'] ) )
	#else:
	#	_goto_page(0)

func _trigger_signal_press(data):
	var button = data[0]
	var group = data[1]
	var menuPath = "res://scene/"
	match group:
		"menu_btn":
			match button.name:
				'btn_home':
					_goto_page( Global.set_page(0) )
					if Global.get_scene() != 'main':
						_change_page(menuPath+'Main.tscn', 0, 'wipe-In')
				'btn_greenhouse':
					_goto_page( Global.set_page(1) )
					if Global.get_scene() != 'main':
						_change_page(menuPath+'Main.tscn', 1, 'wipe-In')
				'btn_yard':
					_goto_page( Global.set_page(2) )
					if Global.get_scene() != 'main':
						_change_page(menuPath+'Main.tscn', 2, 'wipe-In')
				'btn_market':
					_goto_page( Global.set_page(3) )
					if Global.get_scene() != 'main':
						_change_page(menuPath+'Main.tscn', 3, 'wipe-In')
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
			var pageName = Global.get_page_name()
			var btnType = button.name.split('_')[1]
			var isPrimary = false
			if btnType == 'primary':
				isPrimary = true
			match pageName:
				'rumah':
					print("Masuk rumah")
				'rumah kaca':
					print('Masuk rumah kaca')
					_change_page(menuPath+'menu/GreenHouse.tscn', 0, 'wipe-In')
				'kebun belakang':
					if isPrimary:
						print("Masuk Kebun Saya")
					else:
						print("Masuk Kebun Tetangga")
				'toko':
					print('Masuk Toko')
					_change_page(menuPath+'menu/Market.tscn', 0, 'wipe-In')
					
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


### Transition ###
func _play_transition():
	if Global.get_change_scene().has('animation'):
		var animType = Global.get_change_scene()['animation']
		$transition/overlay_transition.show()
		$transition.play(animType)
		print("Play ",animType)

func _transition_animation_finished(anim_name):
	var animation = anim_name.split('-')[0]
	var type = anim_name.split('-')[1]
	if type == "In":
		type = "Out"
		Global.append_change_scene('animation',animation+'-'+type)
	else:
		_goto_page( Global.set_page( Global.get_change_scene()['page'] ) )
		Global.clear_change_scene()
	
	if Global.get_change_scene().has('path'):
		get_tree().change_scene( Global.get_change_scene()['path'] )
		pass

func _change_page(scenePath, page, animation):
	Global.append_change_scene('path',scenePath)
	Global.append_change_scene('page',page)
	Global.append_change_scene('animation',animation)
	_play_transition()


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



