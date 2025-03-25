extends Node

#region Tracked variables
var actor_address : Dictionary[Genum.Actors, String]= {
	Genum.Actors.LUCAS: "res://assets/imports/graphics/characters/Lucas Rivers/lucas_normal.png",
	Genum.Actors.VICTOR: "res://assets/imports/graphics/characters/Victor Thorne/victor_normal.png",
	Genum.Actors.MARINA: "res://assets/imports/graphics/characters/Marina Thorne/marina_normal.png"
}
var current_case : Genum.CurrentCase = Genum.CurrentCase.NONE
#endregion

#region General helpers
func delay_func(callable: Callable, time: float, deferred: bool = true):
	if callable.is_valid():
		await get_tree().create_timer(time).timeout
		
		if deferred:
			callable.call_deferred()
		else:
			callable.call()

func wait(seconds:float = 1.0):
	return get_tree().create_timer(seconds).timeout
	
#endregion
