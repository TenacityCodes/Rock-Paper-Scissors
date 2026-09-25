extends Node2D

enum OPTIONS {ROCK, PAPER, SCISSORS}

@onready var player_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/Player Selection"
@onready var cpu_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/CPU Selection"

@onready var outcome_label = $"Outcome Display/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Outcome"
@onready var outcome_to_display = $"Outcome Display"

var player_selection_default_label: String = "You Chose: "
var cpu_selection_default_label: String = "CPU Chose: "

var player_choice: int = -1
var cpu_choice: int = 0

func _ready() -> void:
	outcome_to_display.visible = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("continue"):
		cpu_select()
		determine_outcome()

	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func cpu_select():
	cpu_choice = randi_range(OPTIONS.ROCK,OPTIONS.SCISSORS)
	cpu_selection_label.text = cpu_selection_default_label + OPTIONS.keys()[cpu_choice]

func determine_outcome():
	var outcome: String = ""
	
	var combos = {OPTIONS.ROCK: OPTIONS.SCISSORS, OPTIONS.PAPER: OPTIONS.ROCK, OPTIONS.SCISSORS: OPTIONS.PAPER}
	
	if (player_choice == -1):
		outcome = "No Input Entered"
	elif (player_choice == cpu_choice): # TIE
		outcome = "IT'S A TIE!"
	elif (combos[player_choice] == cpu_choice): # WIN
		outcome = "YOU WIN!"
	else: # LOSE
		outcome = "YOU LOSE."
	
	outcome_to_display.visible = true
	outcome_label.text = outcome

func _on_rock_btn_button_down() -> void:
	player_choice = OPTIONS.ROCK
	player_selection_label.text = player_selection_default_label + "ROCK"

func _on_paper_btn_button_down() -> void:
	player_choice = OPTIONS.PAPER
	player_selection_label.text = player_selection_default_label + "PAPER"

func _on_scissors_btn_button_down() -> void:
	player_choice = OPTIONS.SCISSORS
	player_selection_label.text = player_selection_default_label + "SCISSORS"
