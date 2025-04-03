extends Node2D

var in_rock_area: bool = false
var in_paper_area: bool = false
var in_scissors_area: bool = false

var rock: int = 1
var paper: int = 2
var scissors: int = 3

@onready var display_player_selection = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/Player Selection"
@onready var display_cpu_selection = $"Choices Display/PanelContainer/MarginContainer/VBoxContainer/CPU Selection"

@onready var display_outcome_label = $"Outcome Display/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Outcome"
@onready var outcome_to_display = $"Outcome Display"

var player_choice: int = 0
var cpu_choice: int = 0

func _ready() -> void:
	outcome_to_display.visible = false

func _on_rock_area_2d_mouse_entered() -> void:
	in_rock_area = true
	print("Rock area: ", in_rock_area)

func _on_rock_area_2d_mouse_exited() -> void:
	in_rock_area = false
	print("Rock area: ", in_rock_area)

func _on_paper_area_2d_mouse_entered() -> void:
	in_paper_area = true
	print("Paper area: ", in_paper_area)

func _on_paper_area_2d_mouse_exited() -> void:
	in_paper_area = false
	print("Paper area: ", in_paper_area)

func _on_scissors_area_2d_mouse_entered() -> void:
	in_scissors_area = true
	print("Scissors area: ", in_scissors_area)

func _on_scissors_area_2d_mouse_exited() -> void:
	in_scissors_area = false
	print("Scissors area: ", in_scissors_area)

func _input(event:InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (in_rock_area):
			player_choice = 1 
			print("You selected rock")
		elif (in_paper_area):
			player_choice = 2 
			print("You selected paper")
		elif (in_scissors_area):
			player_choice = 3
			print("You selected scissors")
			
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		cpu_select()
		determine_outcome()

func cpu_select():
	cpu_choice = randi_range(1,3)
	print("cpu choice was: ", cpu_choice)

func determine_outcome():
	var outcome: String = ""
	print("THIS player_choice: ", player_choice)
	print("THIS cpu choice was: ", cpu_choice)
	
	if (cpu_choice == player_choice):
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
		
	print("Outcome: ", outcome)
	outcome_to_display.visible = true
	display_outcome_label.text = outcome
	
		
	
