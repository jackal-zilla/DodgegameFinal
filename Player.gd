extends Area2D

signal hit

export (int) var speed
var screensize
var target = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		target = event.position
	
# Called in every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	var velocity = Vector2() #the player's movement vector
	
	if position.distance_to(target) > 10:
		velocity = target - position
		
		#keyboard controls removed
#if Input.is_action_pressed("ui_right"):
	#	velocity.x += 1
	#if Input.is_action_pressed("ui_left"):
	#	velocity.x -= 1
	#if Input.is_action_pressed("ui_down"):
	#	velocity.y +=1
	#if Input.is_action_pressed("ui_up"):
	#	velocity.y -=1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	target = pos
	show()
	$CollisionShape2D.disabled = false
