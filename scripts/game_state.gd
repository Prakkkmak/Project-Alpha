extends Node

signal state_changed(state: String, value: bool)
signal state_used(state: String)

const SAVE_PATH: String = "user://game_state.save"

# Dictionnaire pour garder une trace de l'état du jeu, spécifiquement avec des valeurs booléennes
var _game_progress: Dictionary = {}

# Définit un état dans le dictionnaire de progression
func set_state(key: String, value: bool = true) -> void:
	_game_progress[key.to_lower()] = value
	state_changed.emit(key.to_lower(), value)

# Récupère un état du dictionnaire de progression. Retourne false si la clé n'existe pas.
func get_state(key: String) -> bool:
	return _game_progress.get(key.to_lower(), false)

func use_state(state: String) -> void:
	print("use state " + state)
	#HACK Change the pickups to false
	state_used.emit(state)
	if state.ends_with("acquired"):
		set_state(state, false)

# Sauvegarde l'état du jeu dans un fichier
func save_game() -> void:
	var save_game_access: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_string: String = JSON.stringify(_game_progress)
	save_game_access.store_line(json_string)
	save_game_access.close()

# Charge l'état du jeu depuis un fichier
func load_game() -> void:
	if !FileAccess.file_exists(SAVE_PATH):
		return
	var save_game_access: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text: String = save_game_access.get_as_text()
	_game_progress = JSON.parse_string(text)


# Réinitialise l'état du jeu
func reset_game() -> void:
	_game_progress.clear()
	save_game()
	print("Game state reset.")
