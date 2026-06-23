extends Node

func play(sound: AudioStream, parent: Node, pitch: float):
	if sound != null and parent != null:
		var stream_player = AudioStreamPlayer.new()
		stream_player.stream = sound
		stream_player.pitch_scale = pitch
		#stream_player.volume_db *= GlobalVars.sfxvolume
		stream_player.connect("finished", Callable(stream_player, "queue_free"))
		parent.add_child(stream_player)
		stream_player.play()
