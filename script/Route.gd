extends Node

var pagePos = {} setget set_page_pos, get_page_pos

func _ready():
	pass # Replace with function body.




func _page_route(scene, page):
	var route = {
		'main' : ['rumah','rumah kaca', 'kebun belakang', 'toko'],
		'toko' : ['biji', 'promo cepat', 'peralatan'],
	}
	return route[scene.to_lower()][page]

func _page_action(page):
	match page:
		'rumah':
			return [ ['Masuk'], 'enter_home' ]
		'rumah kaca':
			return [ ['Masuk'], 'enter_greenhouse' ]
		'kebun belakang':
			return [ ['Kebun Saya', 'Kebun Teman'], 'enter_yard' ]
		'toko':
			return [ ['Berbelanja'], 'enter_market' ]
		
		'biji':
			return [ ['Beli', 'Jual'], 'shop_seed']
		'promo cepat':
			return [ ['Beli', 'Jual'], 'shop_flashsale']
		'peralatan':
			return [ ['Beli', 'Jual'], 'shop_tool']

static func merge_dict(dest, source):
	for key in source:                     # go via all keys in source
		if dest.has(key):                  # we found matching key in dest
			var dest_value = dest[key]     # get value 
			var source_value = source[key] # get value in the source dict           
			if typeof(dest_value) == TYPE_DICTIONARY:       
				if typeof(source_value) == TYPE_DICTIONARY: 
					merge_dict(dest_value, source_value)  
				else:
					dest[key] = source_value # override the dest value
			else:
				dest[key] = source_value     # add to dictionary 
		else:
			dest[key] = source[key]          # just add value to the dest

func set_page_pos(value):
	pagePos = value
	return pagePos
func append_page_pos(name, value):  # Menyimpan koordinat asli dari Page melalui Position2D
	var temp = {name:value}
	return merge_dict(pagePos,temp)
func get_page_pos():
	return pagePos
func get_page_cords(name):           # Kordinat asli dari Page
	var allPos = get_page_pos() 
	if allPos.has(name):
		return get_page_pos()[name]
	else:
		return false
