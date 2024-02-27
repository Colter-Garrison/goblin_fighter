extends Area2D

@onready var healthbar = $Control/HealthBar

var speed := 200
var health := 100

func _ready() -> void:
	healthbar.init_health(health)
	area_entered.connect(_on_area_entered)
	# update the health bar to match the health variable when the game starts
	set_health(health)

func _process(delta):
	var velocity = Vector2.ZERO
	
	$BlueTorch.play()
	
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
		$BlueTorch.animation = "standing"
		
	if Input.is_action_just_pressed("attack"):
		$BlueTorch.animation = "attacking_forward"
	
	position += velocity * delta
	
	if velocity.length() > 0:
		$BlueTorch.animation = "walking"
	 #Only update flip_h if there's horizontal movement
	if velocity.x != 0:
		$BlueTorch.flip_h = velocity.x < 0

func set_health(new_health: int) -> void:
	health = new_health
	get_node("Control/HealthBar").value = health
	healthbar.health = health

func _on_area_entered(_area_that_entered: Area2D) -> void:
	set_health(health - 0)
	get_node("Control/HealthBar").value = health
