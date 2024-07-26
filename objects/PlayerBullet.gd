extends RigidBody2D

@onready var hurt_box = $HurtBox

func init(pos, damage, dir, speed):
	position = pos + dir*120
	hurt_box.Damage = damage
	apply_force(dir*speed)
	
