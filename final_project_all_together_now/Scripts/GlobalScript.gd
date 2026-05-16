extends Node


var completed_levels = [false, false, false]
var levels = [
	"res://Scenes/LevelMaps/main_level_1.tscn",
	"res://Scenes/LevelMaps/main_level_2.tscn",
	"res://Scenes/TestScenes/TestMaps/TestLevel1.tscn"
]
var current_level: int
var total_score: int = 0
var total_deaths: int = 0
var total_game_time: float = 0.0 # Total time across all completed levels
