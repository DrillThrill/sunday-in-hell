extends TankComponent
class_name ShootPreIndustrial

@export var bullet_scene: PackedScene

@export var tank: Tank
@export var bullet_speed := 500.0
@export var bullet_size := 1.0
@export var bullet_damage := 1.0

func summon_bullet(target_position: Vector2):
	var bullet_instance: BasicBullet = bullet_scene.instantiate()
	bullet_instance.global_position = target_position
	
	bullet_instance.tank = tank
	bullet_instance.direction = tank.sprite_node.rotation_degrees - 90
	bullet_instance.color = tank.tank_color
	
	bullet_instance.speed = bullet_speed
	bullet_instance.damage = bullet_damage
	bullet_instance.size = bullet_size
	
	#bullet_instance.set_stats(bullet_speed, bullet_damage, bullet_size)
		#bullet_instance.set_velocity(tank_sprite.rotation_degrees - 90)
		#bullet_instance.set_tank_owner(tank)
		
	tank.add_sibling(bullet_instance)
	