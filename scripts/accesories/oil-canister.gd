extends StaticBody2D

@export var animation_player: AnimationPlayer
@export var explosion_particles: Particle2D

@export var hit_zone: Area2D

@export var explosion_shake: Shake2D

@export var hit_audio: Audio2D
@export var fuse_audio: Audio2D
@export var explosion_audio: Audio2D

var health := 100
var is_igniting := false


func _on_area_2d_area_entered(bullet):
	if is_igniting or not bullet is BasicBullet:
		return
		
	animation_player.play("hit")
	health -= bullet.damage
	check_health()
	bullet.damage_bullet()
	
func check_health():
	if health <= 0:
		is_igniting = true
		animation_player.stop()
		animation_player.play("fuse")
		$FuseTimer.start()
		fuse_audio.start()
	else:
		hit_audio.start()

func _on_fuse_timer_timeout():
	explosion_particles.start()
	explosion_audio.start()
	explosion_shake.start()

	for body in hit_zone.get_overlapping_bodies():
		var distance = body.global_position - global_position
		
		if body.has_meta("is_container"):
			body.linear_velocity = distance.normalized() * distance.length() * 3
			body.last_hit_by_bullet = false
			body.health -= 15000 / distance.length()
			body.check_health()
			
		elif body is Tank:
			var damage = 13000 / distance.length()
			var stats_component: StatsBasic = body.behaviour(Enums.COMPONENTS.STATS)
			stats_component.damage_tank(damage)
			
		elif body.has_meta("is_canister") and body != self:
			body.health -= 25000 / distance.length()
			body.check_health()

	queue_free()
