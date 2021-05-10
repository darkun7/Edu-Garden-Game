extends Node

const trunk  = preload("res://script/trunks/trunk_0_branch.res")

func _ready():
	_create_trunk("0/0;T-50T-100T-170;B2B6B1")
	pass

func _create_trunk(serial:String = "0/0;T-50T-100T-170;B2B1B1"):
	var pos = $spawn_pos.position
		#create node line as trunk
	var obj = trunk.instance()
	obj.name = "trunk_0"
	obj.gene = serial
	$".".add_child(obj)
	var trunk = obj.name
	get_node(trunk).position = pos


func _process(delta):
	#randomize()
	#var res
	#var rng = RandomNumberGenerator.new()
	#res = rng.randi_range(rand_range(-20,20),rand_range(-20,20))
	#print(res)
	pass
