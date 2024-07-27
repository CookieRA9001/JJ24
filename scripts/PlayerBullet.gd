extends RigidBody2D

@onready var hurt_box = $HurtBox

func init(pos, damage, dir, speed):
	position = pos + dir*120
	hurt_box.Damage = damage
	apply_force(dir*speed)

func setPierce(pierce):
	hurt_box.Pierce = pierce
	hurt_box.DamageTime = 0.5/pierce
