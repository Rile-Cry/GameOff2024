extends Node

#region Tracked variables
var current_case : Case
var typing_speed : int = 20
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
