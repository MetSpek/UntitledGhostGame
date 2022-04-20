extends Control

func _ready():
	set_level_select()
	set_difficulty_select()
	

func set_level_select():
	for x in GlobalGameHandler.level_source:
		$VBoxContainer/LevelSelect/LevelSelect.add_item(x.instance().name)

func set_difficulty_select():
	for x in GlobalGameHandler.difficulties:
		$VBoxContainer/LevelDifficulty/DifficultySelect.add_item(x)


func _on_Start_pressed():
	GlobalGameHandler.game_difficulty = GlobalGameHandler.difficulties[$VBoxContainer/LevelDifficulty/DifficultySelect.get_selected_id()]
	print(GlobalGameHandler.game_difficulty)
	get_tree().change_scene(GlobalGameHandler.levels[$VBoxContainer/LevelSelect/LevelSelect.get_selected_id()])
