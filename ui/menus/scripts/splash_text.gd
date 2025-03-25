extends Control

func switch_to_title():
	SceneTransitionManager.transition_to_scene(GameManager.preloader.title_scene)
