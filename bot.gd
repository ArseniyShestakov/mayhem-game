extends KinematicBody2D

var speed
var velocity = Vector2()
var my_owner

func _init():
	add_to_group("allies")

func _ready():
	speed = randi() % 50 + 450 

func _process(delta):
	var change = randi() % 50 + 50
	if change < 80:
		return
	
	var r2 = randi() % 1 + 3
	
	match r2:
		1:
			velocity.x += 1
		2:
			velocity.x -= 1
		3:
			velocity.y += 1
		4:
			velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	velocity = move_and_slide(velocity)
