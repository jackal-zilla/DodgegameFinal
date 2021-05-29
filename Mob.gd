extends RigidBody2D

export (int) var min_speed
export (int) var max_speed
var mob_types = ["walk", "fly", "swim"]
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
