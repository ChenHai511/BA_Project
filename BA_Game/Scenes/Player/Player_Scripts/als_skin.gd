class_name CharacterSkin
extends Node3D


@onready var animation_player: AnimationPlayer = $als/AnimationPlayer

@onready var is_moving : bool = false:
	set(value):
		is_moving = value
		if is_moving:
			animation_player.play("Aris_Original_Move_Ing")
		else:
			animation_player.play("Aris_Original_Normal_Idle")
