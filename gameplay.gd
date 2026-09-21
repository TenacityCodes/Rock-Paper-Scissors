extends Node2D

enum RPS {ROCK, PAPER, SCISSORS}

@onready var player_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/Player Selection"
@onready var cpu_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/CPU Selection"

@onready var outcome_label = $"Outcome Display/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Outcome"
@onready var outcome_to_display = $"Outcome Display"

var player_selection_default_label: String = "You Chose: "
var cpu_selection_default_label: String = "CPU Chose: "

var reset_can_be_pressed: bool

@onready var anticipation_wait_timer: float = 1

var player_choice: int = -1
var cpu_choice: int = 0

func _ready() -> void:
	outcome_to_display.visible = false
	reset_can_be_pressed = true


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		cpu_select()
		await get_tree().create_timer(anticipation_wait_timer).timeout
		determine_outcome()
	
	if (reset_can_be_pressed):
		if Input.is_action_just_pressed("reset"):
			get_tree().reload_current_scene()

func cpu_select():
	cpu_choice = randi_range(RPS.ROCK,RPS.SCISSORS)
	
	cpu_selection_label.text = cpu_selection_default_label + RPS.keys()[cpu_choice]

func determine_outcome():
	var outcome: String = ""
	
	if (player_choice == -1):
		outcome = "No Input Entered"
	
	var combos = {RPS.ROCK: RPS.SCISSORS, RPS.PAPER: RPS.ROCK, RPS.SCISSORS: RPS.ROCK}
	
	if (player_choice == cpu_choice): # TIE
		outcome = "YOU TIE!"
	elif (combos[player_choice] == cpu_choice): # WIN
		outcome = "YOU WIN!"
	else: # LOSE
		outcome = "YOU LOSE!"
	
	outcome_to_display.visible = true
	outcome_label.text = outcome


func _on_rock_btn_button_down() -> void:
	player_choice = RPS.ROCK
	player_selection_label.text = player_selection_default_label + "ROCK"



func _on_paper_btn_button_down() -> void:
	player_choice = RPS.PAPER
	player_selection_label.text = player_selection_default_label + "PAPER"



func _on_scissors_btn_button_down() -> void:
	player_choice = RPS.SCISSORS
	player_selection_label.text = player_selection_default_label + "SCISSORS"
