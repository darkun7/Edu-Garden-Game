extends Node

var scene = "main" setget set_scene, get_scene #Current Scene
var page setget set_page, get_page
var nextPage = 0 setget set_next_page, get_next_page
var targetPosition = "" setget set_target_position, get_target_position

var changeScene = {} setget set_change_scene, get_change_scene

func _ready():
	pass # Replace with function body.





# Set-Get current scene
func set_scene(value):
	scene = value.to_lower()
	return scene
func get_scene():
	return scene

# Set-Get current page name & number
func set_page(value):
	page = value
	return page
func get_page():
	return page
func get_page_name(): # current page name
	return Route._page_route(get_scene(),get_page())

# Set-Get movement position, it's trigger after pres switcher right-left
func set_target_position(value): 
	targetPosition =  Route.get_page_cords(value)
	return targetPosition
func get_target_position():
	return targetPosition

# Go page on "nextPage" variable value
func set_next_page(value):
	nextPage = value
	return nextPage
func get_next_page():
	return nextPage

func set_change_scene(value):
	changeScene = value
	return changeScene
func append_change_scene(name, value):
	var temp = {name:value}
	return Helper.merge_dict(changeScene,temp)
func clear_change_scene():
	changeScene = {}
	return true
func get_change_scene():
	return changeScene
