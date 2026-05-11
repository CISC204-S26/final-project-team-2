extends Node

var completed_levels = [false, false, false]
var total_score: int = 0
var total_deaths: int = 0
var total_game_time: float = 0.0 # Total time across all completed levels
# Current level timer which resets each level
var current_level_time: float = 0.0
var level_timer_running: bool = false
var level_times: Array = [0.0, 0.0, 0.0] # Stores each level's final time once completed

''' messing around with this might delete later
func start_level_timer():
	current_level_time = 0.0
	level_timer_running = true

func stop_level_timer():
	level_timer_running = false

func complete_level(level_index: int):
	stop_level_timer()
	completed_levels[level_index] = true
	level_times[level_index] = current_level_time
	total_game_time += current_level_time

func reset_game():
	total_game_time = 0.0
	current_level_time = 0.0
	level_timer_running = false
	total_score = 0
	total_deaths = 0
	completed_levels = [false, false, false]
	level_times = [0.0, 0.0, 0.0]

func _process(delta):
	if level_timer_running:
		current_level_time += delta
'''
