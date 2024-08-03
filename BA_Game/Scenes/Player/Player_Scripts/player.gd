extends CharacterBody3D

@onready var rotation_root: Node3D = $RotationRoot

@onready var als_skin: CharacterSkin = $RotationRoot/Als_skin

# 移动速度
@export var SPEED = 5.0

# 重力
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

#####视角测试用参数#
@onready var camear_root: Node3D = $CamearRoot
@onready var camera_3d: Camera3D = $CamearRoot/Camera3D


@onready var h_scroll_bar: HScrollBar = $CanvasLayer/HScrollBar

#####视角测试用参数#####
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if $CanvasLayer.visible:
			$CanvasLayer.visible = false
		else:
			$CanvasLayer.visible = true
func _ready() -> void:
	pass

func _process(delta: float) -> void:
	ui_change_view()
	save_game()

func _physics_process(delta: float) -> void:
	# 角色是否在地面上
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(-input_dir.x, 0, -input_dir.y)).normalized()
	
	# 角色移动
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		als_skin.is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		als_skin.is_moving = false
	
	# 角色朝向
	if velocity.length() > 0.1:
		var characterDir = Vector2(velocity.z,velocity.x)
		rotation_root.rotation.y = characterDir.angle()

	move_and_slide()


func ui_change_view() -> void:
	#ui修改角色视角
	## 相机x轴坐标
	$CanvasLayer/Label/x_text.text = str(camera_3d.position.x)
	## 相机Y坐标
	$CanvasLayer/Label2/x_text.text = str(camera_3d.position.y)
	## 距离
	$CanvasLayer/Label3/x_text.text = str(camera_3d.position.z)
	

func _on_down_pressed() -> void:
	camera_3d.position.x += 0.05
func _on_add_pressed() -> void:
	camera_3d.position.x -= 0.05
func _on_down_2_pressed() -> void:
	camera_3d.position.y -= 0.05
func _on_add_2_pressed() -> void:
	camera_3d.position.y += 0.05
func _on_down_3_pressed() -> void:
	camera_3d.position.z -= 0.05
func _on_add_3_pressed() -> void:
	camera_3d.position.z += 0.05



func save_game():
	print("保存游戏")
	
	## 创建SaveGame资源类
	var saved_game :SavedGame = SavedGame.new()
	
	saved_game.p1 = camera_3d.position
	
	## 保存数据资源
	ResourceSaver.save(saved_game,"res://SaveData/SaveGame.tres")
	
func load_game():
	pass

