extends Node3D
@onready var camera_3d: Camera3D = $Camera3D
@onready var camear_root: Node3D = $"."

# 相机旋转速度
@export var rotation_speed: float = 0.01

# 相机可移动的角度
@export_range(-180,180) var max_angel: float = 80
@export_range(-180,180) var min_angel: float = 20

# 相机与人物的距离
@export var distance : float = 30

var x:float = 0
var y:float = 0
func _ready() -> void:
	x = transform.basis.get_euler().x
	y = transform.basis.get_euler().y

#func _process(delta: float) -> void:
	#camear_root.rotation.x = y
	#camear_root.rotation.y = x

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_action_pressed("change_view"):
		camear_root.rotation.y += -event.relative.x * rotation_speed
		camear_root.rotation.x += event.relative.y * rotation_speed

