extends Node


var stream_players_pool: Array[AudioStreamPlayer] = []
var sfx_dir: String = "res://assets/audio/sfx/"
var sfx_pool: Dictionary[String, AudioStream] = {}
var ambient_dir: String = "res://assets/audio/ambient/"
var ambient_pool: Dictionary[String, AudioStream] = {}

func _ready():
	sfx_pool = _load_sounds(sfx_dir)
	ambient_pool = _load_sounds(ambient_dir)
	
	setup_pool()

func setup_pool():
	var sfx_player = AudioStreamPlayer.new()
	var ambient_player = AudioStreamPlayer.new()
	
	sfx_player.name = "SFXPlayer"
	sfx_player.bus = "SFX"
	stream_players_pool.append(sfx_player)
	add_child(sfx_player)
	
	ambient_player.name = "AmbientPlayer"
	ambient_player.bus = "Ambient"
	stream_players_pool.append(ambient_player)
	add_child(ambient_player)

func play(stream_name: String, bus: String = "SFX", volume: float = 1.0) -> void:
	var stream : AudioStream
	match(bus):
		"SFX":
			if sfx_pool.has(stream_name):
				stream = sfx_pool.get(stream_name)
			else:
				print("Could not find sfx with name " + stream_name)
		"Ambient":
			if ambient_pool.has(stream_name):
				stream = ambient_pool.get(stream_name)
			else:
				print("Cound not find ambient with name " + stream_name)
		"-":
			pass
	
	if _bus_is_valid(bus):
		var audio_player : AudioStreamPlayer
		match(bus):
			"SFX":
				audio_player = stream_players_pool.get(0)
			"Ambient":
				audio_player = stream_players_pool.get(1)
		
		if stream:
			audio_player.stream = stream
			audio_player.play()

func play_random_stream(streams: Array[AudioStream] = [], bus: String = "SFX", volume: float = 1.0):
	if streams.is_empty() or not _bus_is_valid(bus):
		return
		
	play(streams.pick_random(), bus, volume)

func stop_streams_from_bus(bus: String = "SFX"):
	for player: AudioStreamPlayer in stream_players_pool:
		if player.bus.to_lower() == bus.to_lower():
			player.stop()

func stop_streams_from_buses(buses: Array[String] = ["SFX"]):
	for bus in buses:
		stop_streams_from_bus(bus)

func _load_sounds(dir: String) -> Dictionary[String, AudioStream]:
	var sound_list := ResourceLoader.list_directory(dir)
	var result : Dictionary[String, AudioStream]
	for sound in sound_list:
		result.set(sound.split(".")[0], ResourceLoader.load(dir + sound, "AudioStream"))
	
	return result

func _bus_is_valid(bus: String) -> bool:
	return AudioServer.get_bus_index(bus) != -1
		
