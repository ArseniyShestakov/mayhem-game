extends KinematicBody2D

export (int) var speed = 600

onready var uiCharge = $ChargeText
var velocity = Vector2()

var is_player = false
var charging = false
var charge = 0.0 setget _set_charge
var level_scene
var bot_scene
var bullet_scene

func _init():
	bot_scene = load("res://bot.tscn")
	bullet_scene = load("res://bullet.tscn")
	_set_charge(0.0)

func get_input():
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot"):
		shoot()

	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func random_input():
	var change = randi() % 50 + 50
	if change < 80:
		return
	
	if change < 25:
		velocity.x += 1
	elif change > 25 and change < 50:
		velocity.x -= 1
	elif change > 50 and change < 75:
		velocity.y += 1
	else:
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _set_charge(val):
	charge = val
	if uiCharge:
		uiCharge.text = "c: " + String(val)

func _physics_process(delta):
	if is_player:
		get_input()
	else:
		random_input()
	velocity = move_and_slide(velocity)
	if charging:
		_set_charge(charge + delta)

func _on_ChargerArea_body_entered(body):
	charging = true

func _on_ChargerArea_body_exited(body):
	charging = false

func _on_Node2D_level_clicked(pos):
	if charge < 1.0:
		return
	var bot = bot_scene.instance()
	bot.global_position = pos
	bot.my_owner = self
	level_scene.add_child(bot)
	_set_charge(charge - 1.0)

func shoot():
	var b = bullet_scene.instance()
	b.my_owner = self
	b.transform = $ShootFrom.global_transform
	owner.add_child(b)
