extends CharacterBody2D



@export var MAX_SPEED = 100
@export var ACC = 10.0
@export var DASH_MULTIPLIER = 30.0
@export var DASH_DURATION = 0.1
@export var DASH_RELOAD_TIME = 3
var dashing : bool = false
var dash_time_left = 0
var dash_reload_time_left = 0


func _physics_process(delta):
	
	
	var moved : bool = false
	
	if dashing:
		dash_time_left -=delta
		if dash_time_left<0:
			dashing = false
			dash_time_left = 0
			normalize_speed()
	
	if dash_reload_time_left > 0:
		dash_reload_time_left -= delta
	elif dash_reload_time_left < 0:
		dash_reload_time_left = 0
	
	if Input.is_action_pressed("Forward"):
		velocity.y -= ACC
		moved = true
	if Input.is_action_pressed("Backward"):
		velocity.y += ACC
		moved = true	
	if Input.is_action_pressed("Left"):
		velocity.x -= ACC
		moved = true	
	if Input.is_action_pressed("Right"):
		velocity.x += ACC
		moved = true
	if Input.is_action_pressed("Dash") and !dashing and dash_reload_time_left == 0:
		velocity*=DASH_MULTIPLIER
		dashing = true
		dash_time_left = DASH_DURATION
		dash_reload_time_left = DASH_RELOAD_TIME
	
	
	if !dashing:
		normalize_speed()
		
		if !moved:
			velocity*=0.1
	
	move_and_slide()

func normalize_speed():
	if velocity.length()>MAX_SPEED:
		velocity*=(MAX_SPEED/velocity.length())
