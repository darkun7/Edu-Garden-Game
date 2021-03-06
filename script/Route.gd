extends Node

var pagePos = {} setget set_page_pos, get_page_pos

func _ready():
	pass # Replace with function body.




func _page_route(scene, page):
	var route = {
		'main' : ['rumah','rumah kaca', 'kebun belakang', 'toko'],
		'market' : ['benih', 'promo cepat', 'peralatan'],
		'greenhouse': ['papan 1','papan 2','papan 3']
	}
	if page >= len(route[scene.to_lower()]):
		return 'Memuat...'
	else:
		return route[scene.to_lower()][page]

func _page_action(page):
	match page:
		'Memuat...': #aslinya ini no-page
			return [ [''],'' ]
		'rumah':
			return [ ['Masuk'], 'enter_home' ]
		'rumah kaca':
			return [ ['Masuk'], 'enter_greenhouse' ]
		'kebun belakang':
			return [ ['Kebun Saya', 'Kebun Teman'], 'enter_yard' ]
		'toko':
			return [ ['Berbelanja'], 'enter_market' ]
		
		'benih':
			return [ ['Beli', 'Jual'], 'shop_seed']
		'promo cepat':
			return [ ['Beli', 'Jual'], 'shop_flashsale']
		'peralatan':
			return [ ['Beli', 'Jual'], 'shop_tool']
		
		'papan 1':
			return [[], 'papan1']
		'papan 2':
			return [[], 'papan2']
		'papan 3':
			return [[], 'papan3']

func set_page_pos(value):
	pagePos = value
	return pagePos
func append_page_pos(name, value):  # Menyimpan koordinat asli dari Page melalui Position2D
	var temp = {name:value}
	return Helper.merge_dict(pagePos,temp)
func get_page_pos():
	return pagePos
func get_page_cords(name):           # Kordinat asli dari Page
	var allPos = get_page_pos() 
	if allPos.has(name):
		return get_page_pos()[name]
	else:
		return false
