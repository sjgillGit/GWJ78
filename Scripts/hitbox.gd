extends Area2D
class_name HitboxComponent

@export var damage: int = 1 : set = set_damage, get = get_damage

func set_damage(value: int):
	print("Hitbox script damage trigger")
	damage = value
	#if health_component:
	#	health_component.damage(attack)
func get_damage() -> int:
	return damage
