extends Area2D

@onready var healthbar = $Control/HealthBar

var speed := 200
var health := 100
var gold := 0

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
		
	if Input.is_action_just_pressed("attack"):
		$BlueTorch.animation = "attacking_forward"
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$BlueTorch.animation = "standing"
	
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

func set_gold_amount(new_gold_amount: int) -> void:
	gold = new_gold_amount
	print("Gold Amount: ", str(gold))

func _on_area_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group('enemy'):
		if health > 0:
			set_health(health - 10)
		else:
			health = 0
	elif area_that_entered.is_in_group('gold'):
		set_gold_amount(gold + 10)
