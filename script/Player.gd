extends KinematicBody2D

var speed = Vector2(64,64)

func _ready():
	pass # Replace with function body.

#func _process(delta):
#	var target = Global.get_target_position()
#	if(target == self.get_global_transform_with_canvas().get_origin()):
#		print('true')
#		Global.set_target_position(null)
#	if(target != null):
#		var dir_v = (target - global_position).normalized()
#		speed.x +=0.5 #biar agak cepet
#		move_and_slide(dir_v*speed*2)
	
const SMOOTH_SPEED = 1
var repos = Vector2()
var repos_velo = Vector2()
#var position = Vector2()

func _process(delta):
	var objPos = Global.get_target_position()#.get_mouse_pos()
	var destination = self.position
	if( typeof(objPos) == TYPE_VECTOR2 ):
		var velo = (objPos.x- destination.x)*1;
		position.x += velo*delta
		#move_and_slide(repos_velo)
	#	repos.x = objPos.x- destination.x
	#	repos_velo.x = repos.x * SMOOTH_SPEED * delta
	#	position.x += repos_velo.x
	#	move_and_slide(repos_velo)
