extends CharacterBody2D

var speed = 25

@onready var player = get_node("/root/Level1/Player")
@onready var anim =$AnimationPlayer

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()
	anim.play("Walk")
