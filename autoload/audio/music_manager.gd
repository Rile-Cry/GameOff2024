extends Node

signal added_music_to_bank(_name: String, stream: AudioStream)
signal removed_music_from_bank(_name: String)
signal changed_stream(from: AudioStream, to: AudioStream)
signal started_stream(audio_stream_player: AudioStreamPlayer, new_stream: AudioStream)
signal finished_stream(audio_stream_player: AudioStreamPlayer, old_stream: AudioStream)

## Dictionary<string, AudioStream>
var music_dir : String = "res://assets/audio/music/"
var music_bank : Dictionary[String, AudioStream] = {}
var audio_stream_player : AudioStreamPlayer
var in_intro := false

func _ready():
	_create_audio_stream_player()
	_load_all_streams()

func play_music(stream_name: String):
	var found := false
	for song in music_bank.keys():
		if song.contains(stream_name):
			found = true
			if in_intro:
				if song.contains("Loop"):
					audio_stream_player.stream = music_bank.get(song)
					audio_stream_player.play()
					in_intro = false
			else:
				if song.contains("Intro"):
					audio_stream_player.stream = music_bank.get(song)
					audio_stream_player.play()
					in_intro = true
	
	if not found:
		push_error("There was no song " + stream_name + " in the Music Bank.")

func add_stream_to_music_bank(stream_name: String, stream: AudioStream):
	music_bank[stream_name] = stream
	added_music_to_bank.emit(stream_name, stream)

func remove_stream_from_music_bank(stream_name: String):
	if music_bank.has(stream_name):
		music_bank.erase(stream_name)
		removed_music_from_bank.emit(stream_name)

func stop_music() -> void:
	audio_stream_player.stop()
	in_intro = false

func _create_audio_stream_player():
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.name = "MainAudioStreamPlayer"
	audio_stream_player.bus = "Music"
	audio_stream_player.autoplay = false
	
	add_child(audio_stream_player)
	
	audio_stream_player.finished.connect(on_finished_audio_stream_player.bind(audio_stream_player))

func on_finished_audio_stream_player(audio_stream_player: AudioStreamPlayer):
	finished_stream.emit(audio_stream_player, audio_stream_player.stream)
	if in_intro:
		var song : String = audio_stream_player.stream.resource_name
		song = song.split(".")[0]
		play_music(song)

func _load_all_streams() -> void:
	var song_list = ResourceLoader.list_directory(music_dir)
	for song in song_list:
		var song_stream = ResourceLoader.load(music_dir + song, "AudioStream")
		add_stream_to_music_bank(song.split(".")[0], song_stream)
