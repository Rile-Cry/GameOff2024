extends Window

var users:= {
	"Marcus": true,
	"Paula": true,
	"Jingo": false,
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_online()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_online()


func init_online() -> void:
	pass


func check_online() -> void:
	pass
