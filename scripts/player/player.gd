extends CharacterBody3D

class_name Player

#Reference
@export var player_camera: Camera3D
@export var player_mesh: CSGMesh3D
@export var interaction_cast: RayCast3D
@export var player_ui: player_ui_manager
@export var inventory : Inventory

@export_category("Checkbox")
@export var can_move : bool = true

@export_category("Camera parameters")
@export var sensitivity_hori : float = 0.1
@export var sensitivity_vert : float = 0.1
@export_range(-PI/2, PI/2) var min_XClamp : float
@export_range(-PI/2, PI/2) var max_XClamp : float

@export_category("Inputs parameters")
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export_category("Fatigue parameters")
var max_fatigue_default : int = 50
var max_fatigue_modifier : int = 0
var current_fatigue : int = 0

var _cam_input_direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	GameManager.player = self

func _physics_process(delta: float) -> void:
	_camera_mouvement(delta)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : Vector3 = get_mouvement_direction()
	if !can_move :
		direction = Vector3.ZERO
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	interaction_management()
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("escape"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _unhandled_input(event: InputEvent) -> void:
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion) :
		_cam_input_direction = event.screen_relative

func _camera_mouvement(delta: float) -> void :
	player_camera.rotation.x -= _cam_input_direction.y * delta * sensitivity_vert
	player_camera.rotation.y -= _cam_input_direction.x * delta * sensitivity_hori
	player_camera.rotation.x = clampf(player_camera.rotation.x, min_XClamp, max_XClamp)
	_cam_input_direction = Vector2.ZERO

func get_mouvement_direction() -> Vector3 :
	var raw_input : Vector2 = Input.get_vector("player_left", "player_right", "player_forward", "player_backward")
	var forward : Vector3 = player_camera.global_basis.z
	var right : Vector3 = player_camera.global_basis.x
	var mouvement_direction : Vector3 = forward * raw_input.y + right * raw_input.x
	mouvement_direction.y = 0
	return mouvement_direction.normalized()
	
func interaction_management() -> void :
	if interaction_cast.is_colliding():
		var collider := interaction_cast.get_collider()
		if collider is interactable_base :
			player_ui.change_interactable_text(collider.display_interact_text())
			if(Input.is_action_just_pressed("player_interaction") and collider.can_interact()):
				collider.interact()
			return
	player_ui.change_interactable_text("")

func change_fatigue(cost : int) -> void :
	current_fatigue = clamp(current_fatigue + cost, 0, max_fatigue_default + max_fatigue_modifier)
	print("current fatigue : ", current_fatigue)
	
func can_do_action(cost :int) -> bool :
	return max_fatigue_default + max_fatigue_modifier >= current_fatigue + cost
	
func reset_fatigue() -> void :
	max_fatigue_modifier = 0
	current_fatigue = 0
