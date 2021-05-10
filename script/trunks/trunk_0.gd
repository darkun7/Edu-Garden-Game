extends Line2D

export (String) var gene

var grow_stage = 0 setget set_grow_stage, get_grow_stage   #Tingkat pertumbuhan (max: 8)
var branch_amount = 0 setget set_branch_amount, get_branch_amount   #Jumlah cabang batas (max: 5)
var branch_level =  0 setget set_branch_level, get_branch_level   #Tingkat cabang saat ini (max: 3)

var growline = 0 setget set_growline, get_growline
var growstep =  0 setget set_growstep, get_growstep

func serialize(serial:String = "0/0;T-50T-100T-170;B2B1B1")->Dictionary:
	var seeds  = serial.split(";",false)
	var p_type = seeds[0].split("/",false)
	var trunk  = seeds[1].split('T',false)
	var branch = seeds[2].split("B",false)
	seeds = {"trunk_type": p_type[0],
			 "branch_type": p_type[1],
			 "trunk": trunk,
			 "branch": branch}
	return seeds
func gene(kind:String, index:int = -1):
	var result = false
	match kind:
		"trunk_type", "branch_type","trunk", "branch":
			if index < 0:
				result =  serialize(gene)[kind]
			else:
				result = serialize(gene)[kind][index]
		"sum_branch":
			var temp = 0
			for i in gene("branch"):
				temp += int(i)
			result = temp
	return result

func _ready():
	set_branch_amount(gene("sum_branch"))
	randomize()
	generate_grow_line()
	grow(get_growstep().size())
	print(get_growstep())
	pass

func generate_grow_line():
	var rng = RandomNumberGenerator.new()
	var amount_trunk = gene("trunk").size()
	var growth_stage = amount_trunk + gene("sum_branch")
	#Plant Type = 0
	var pos
	var step = {}
	var line = []
	for trunk in range(amount_trunk):
		#print(">> Trunk-",trunk)
		if(trunk == 0):
			pos = [Vector2(0,0),
				   Vector2(rng.randi_range(rand_range(-20,20),rand_range(-20,20)), gene("trunk",0))]
		else:
			var prev_trunk = step["trunk"+str(trunk-1)]
			pos = [prev_trunk[1],
				   Vector2(rng.randi_range(rand_range(-20,20),rand_range(-20,20))*trunk+1, gene("trunk",trunk))]
		step["trunk"+str(trunk)] = pos
		line.append("trunk"+str(trunk))
		#print(pos)
		for branch in range(gene("branch", trunk)):
			#print(">> Trunk-",trunk," Branch-",branch)
			var recent_trunk = step["trunk"+str(trunk)]
			pos = [recent_trunk[1],
				   Vector2(
				   rng.randi_range(rand_range(-40,40),rand_range(-40,40)), #sumbu x cabang sekarang (random)
				   recent_trunk[1].y - rand_range(20,50)) ] #sumbu y cabang sebelumnya +random
			step["branch"+str(trunk)+"-"+str(branch)] = pos
			line.append("branch"+str(trunk)+"-"+str(branch))
	set_growstep(step)
	set_growline(line)

func grow(step:int):
	var steps = get_growstep()
	for line in range(step):
		var key = get_growline()[line]
		
		var obj = Line2D.new()
		obj.name = key
		$".".add_child(obj)
		obj.width = 2
		obj.add_point ( get_growstep()[key][0] ) #parent
		obj.add_point ( get_growstep()[key][1] ) #target
		obj.set_default_color( Color(255, 0, 0) ) 

	set_grow_stage(get_grow_stage()+1)
	pass

# == Setter and Getter ==
func set_grow_stage(value):
	grow_stage = value
	pass
func get_grow_stage():
	return grow_stage 

func set_branch_amount(value):
	branch_amount = value
	pass
func get_branch_amount():
	return branch_amount 

func set_branch_level(value):
	branch_level = value
	pass
func get_branch_level():
	return branch_level 

func set_growline(value):
	growline = value
	pass
func get_growline():
	return growline 
func set_growstep(value):
	growstep = value
	pass
func get_growstep():
	return growstep
