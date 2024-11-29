extends Control
class_name TutorialPopup

@export_category("Control Nodes")
@export var tab_container : TabContainer
@export var prev_b : Button
@export var next_b : Button
@export var close_b : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tab_container.tab_changed.connect(tab_change)
	tab_container.set_current_tab(0)
	SfxAudio.play_audio("Popup")
	
	prev_b.pressed.connect(previous)
	next_b.pressed.connect(next)
	close_b.pressed.connect(close)
	close_b.hide()

func tab_change(current_tab : int) -> void:
	var tab_count : int = tab_container.get_children().size()
	
	if current_tab == 0:
		prev_b.disabled = true
		next_b.disabled = false
		close_b.disabled = true
		
		prev_b.hide()
		next_b.show()
		close_b.hide()
	elif current_tab < (tab_count-1):
		prev_b.disabled = false
		next_b.disabled = false
		close_b.disabled = true
		
		prev_b.show()
		next_b.show()
		close_b.hide()
	else:
		prev_b.disabled = false
		next_b.disabled = true
		close_b.disabled = false
		
		prev_b.show()
		next_b.hide()
		close_b.show()

func previous():
	tab_container.current_tab -= 1
	if SfxAudio:
		SfxAudio.play_audio("Object Select")

func next():
	tab_container.current_tab += 1
	if SfxAudio:
		SfxAudio.play_audio("Object Select")

func close():
	close_b.disabled = true
	$AnimationPlayer.play_backwards("open")
	await $AnimationPlayer.animation_finished
	queue_free()
