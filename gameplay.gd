extends Node2D

var in_rock_area: bool = false
var in_paper_area: bool = false
var in_scissors_area: bool = false

var rock: int = 1
var paper: int = 2
var scissors: int = 3

@onready var player_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/Player Selection"
@onready var cpu_selection_label = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/CPU Selection"

@onready var outcome_label = $"Outcome Display/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Outcome"
@onready var outcome_to_display = $"Outcome Display"

var player_selection_basic_label: String = "You Chose: "
var cpu_selection_basic_label: String = "CPU Chose: "

var items_can_be_changed: bool

var reset_can_be_pressed: bool

@onready var anticipation_wait_timer: float = 0.5

var player_choice: int = 0
var cpu_choice: int = 0

func _ready() -> void:
	outcome_to_display.visible = false
	items_can_be_changed = true
	reset_can_be_pressed = true

func _on_rock_area_2d_mouse_entered() -> void:
	in_rock_area = true

func _on_rock_area_2d_mouse_exited() -> void:
	in_rock_area = false

func _on_paper_area_2d_mouse_entered() -> void:
	in_paper_area = true

func _on_paper_area_2d_mouse_exited() -> void:
	in_paper_area = false

func _on_scissors_area_2d_mouse_entered() -> void:
	in_scissors_area = true

func _on_scissors_area_2d_mouse_exited() -> void:
	in_scissors_area = false

func _input(event:InputEvent) -> void:
	if (items_can_be_changed):
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if (in_rock_area):
				player_choice = 1 
				player_selection_label.text = player_selection_basic_label + "Rock"
			elif (in_paper_area):
				player_choice = 2 
				player_selection_label.text = player_selection_basic_label + "Paper"
			elif (in_scissors_area):
				player_choice = 3
				player_selection_label.text = player_selection_basic_label + "Scissors"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		if (items_can_be_changed):
			reset_can_be_pressed = false
			items_can_be_changed = false
			cpu_select()
			await get_tree().create_timer(anticipation_wait_timer).timeout
			determine_outcome()
			reset_can_be_pressed = true
	
	if (reset_can_be_pressed):
		if Input.is_action_just_pressed("reset"):
			reset()

func cpu_select():
	cpu_choice = randi_range(1,3)

	if (cpu_choice == 1):
		cpu_selection_label.text = cpu_selection_basic_label + "Rock"
	elif (cpu_choice == 2):
		cpu_selection_label.text = cpu_selection_basic_label + "Paper"
	elif (cpu_choice == 3):
		cpu_selection_label.text = cpu_selection_basic_label + "Scissors"

func determine_outcome():
	var outcome: String = ""
	
	if (player_choice == 0):
		outcome = "No Input Entered"
	
	elif (cpu_choice == player_choice):
		outcome = "It's A Draw!"
		
	elif (player_choice == 1): # Player chooses rock
		if (cpu_choice == 2): # CPU chooses paper
			outcome = "You Lost."
		if (cpu_choice == 3): # CPU chooses scissors
			outcome = "You Win!"
	
	elif (player_choice == 2): # Player chooses paper
		if (cpu_choice == 1): # CPU chooses rock
			outcome = "You Win!"
		if (cpu_choice == 3): # CPU chooses scissors
			outcome = "You Lost."
			
	elif (player_choice == 3): # Player chooses scissors
		if (cpu_choice == 1): # CPU chooses rock
			outcome = "You Lost."
		if (cpu_choice == 2): # CPU chooses paper
			outcome = "You Win!"
	
	outcome_to_display.visible = true
	outcome_label.text = outcome
	
func reset():
	player_choice = 0
	cpu_choice = 0
	items_can_be_changed = true
	player_selection_label.text = player_selection_basic_label
	cpu_selection_label.text = cpu_selection_basic_label
	outcome_to_display.visible = false
