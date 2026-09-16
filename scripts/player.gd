extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -250.0

@onready var animation_pl: AnimatedSprite2D = $Animation
@onready var attack_collision: CollisionShape2D = $"attack collision"

var is_attacking = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if not is_attacking and Input.is_action_just_pressed("attack"):
		attack_collision.disabled = false
		animation_pl.play("Attack")
		is_attacking = true
		return
	
	var direction := Input.get_axis("ui_left", "ui_right")
	
	
	if direction != 0:
		velocity.x = direction * SPEED
		animation_pl.play("run")
		
		if direction > 0:
			animation_pl.flip_h = false
		else:
			animation_pl.flip_h = true
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_pl.play("Idle")
	
	move_and_slide()


func _on_animation_animation_finished() -> void:
	if animation_pl.animation == "Attack":
		is_attacking = false
		attack_collision.disabled = true
