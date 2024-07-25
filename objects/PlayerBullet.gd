extends RigidBody2D

@onready var hurt_box = $HurtBox

func init(damage, dir, speed):
	hurt_box.Damage = damage
	apply_force(dir*speed)
	
