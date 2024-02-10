extends Area2D

@export var speed = 400

func _process(delta):
	$blue_torch.play()
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$blue_torch.animation = "standing"

	position += velocity * delta

	if velocity.x || velocity.y != 0:
		$blue_torch.animation = "walking"
		$blue_torch.flip_h = velocity.x < 0

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
