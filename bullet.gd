extends Area2D

var speed = 750

var my_owner

func _physics_process(delta):
	position += transform.x * speed * delta

func _ready():
	pass

func _on_bullet_body_entered(body):
	if body.is_in_group("allies"):
		body.queue_free()
	queue_free()
