extends TankComponent
class_name DeathBasic

const component_name = "death"

@export var stats: StatsBasic
@export var spectator_scene: PackedScene
@export var animation_player: AnimationPlayer
@export var death_scene: PackedScene
@export var predeath_sound: Audio2D

var is_dying := false

func _ready():
	safety_check([stats, spectator_scene])
	stats.connect("health_change", _on_health_change)
		
func _on_health_change(health):
	if health > 0 or is_dying:
		return

	animation_player.play("death")
	
	if tank.is_client:
		Overlay.show_bars()
	
	var timer: Timer = Timer.new()
	timer.wait_time = 0.35
	timer.autostart = true
	timer.connect("timeout", death)
	add_child(timer)
	
	predeath_sound.start()

func death():
	var death_instance = death_scene.instantiate()
	death_instance.set_meta("particle_color", tank.tank_color)
	tank.add_sibling(death_instance)
	death_instance.global_position = tank.global_position
	tank.queue_free()
	
	if tank.is_client: 
		var spectator_instance = spectator_scene.instantiate()
		spectator_instance.is_client = tank.is_client
		spectator_instance.camera_zoom = tank.default_zoom
		tank.add_sibling(spectator_instance)
		spectator_instance.global_position = tank.global_position
		Global.player_lives -= 1

func instant_death():
	if tank.is_client:
		Overlay.show_bars()
	death()
