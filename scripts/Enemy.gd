extends Area2D

@onready var healthbar = $Control/HealthBar

var health := 100

func _ready() -> void:
	healthbar.init_health(health)
	area_entered.connect(_on_area_entered)
	# update the health bar to match the health variable when the game starts
	set_health(health)

func _process(delta):
	dead()

func set_health(new_health: int) -> void:
	health = new_health
	get_node("Control/HealthBar").value = health
	healthbar.health = health

func _on_area_entered(area_that_entered: Area2D) -> void:
	if area_that_entered.is_in_group('player'):
		if health > 0:
			set_health(health - 50)
		else:
			health = 0

func dead():
	if health <= 0:
		$RedKnight.animation = "dead"
