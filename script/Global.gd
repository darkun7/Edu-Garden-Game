extends Node

var scene = "main" setget set_scene, get_scene #Current Scene
var page = 0 setget set_page, get_page
var targetPosition = "" setget set_target_position, get_target_position

func _ready():
	pass # Replace with function body.






func set_scene(value):
	scene = value
	return scene
func get_scene():
	return scene

func set_page(value):
	page = value
	return page
func get_page():
	return page
func get_page_name(): # current page name
	return Route._page_route(get_scene(),get_page())

func set_target_position(value): 
	targetPosition =  Route.get_page_cords(value)
	return targetPosition
func get_target_position():
	return targetPosition
