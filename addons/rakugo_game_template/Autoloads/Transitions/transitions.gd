extends GridContainer

# Define grid dimensions and updated word list
const GRID_SIZE = 10
var words_to_find = ["CHEMISTRY", "AGGIE", "BLUFORD", "DEESE", "DOWDY", "CHANCELLOR", "STUDENT CENTER", "CHRISTMAS"]
var selected_letters = []
var grid_buttons = []

# Reference to the Label node to show found words
onready var found_words_label = $Label

func _ready():
	# Set grid size and initialize the grid
	columns = GRID_SIZE
	_create_grid()
	_place_words_in_grid()

func _create_grid():
	# Populate grid with buttons for each letter
	for i in range(GRID_SIZE * GRID_SIZE):
		var button = Button.new()
		button.text = char(rand_range(65, 90))  # Random letter from A to Z
		button.connect("pressed", self, "_on_button_pressed", [button])
		grid_buttons.append(button)
		add_child(button)

func _place_words_in_grid():
	# Insert words from the list into the grid (simplified to only horizontal placement here)
	for word in words_to_find:
		# Ensure placement within grid boundaries
		var start_row = randi() % GRID_SIZE
		var start_col = randi() % max(1, (GRID_SIZE - word.length()))
		for j in range(word.length()):
			grid_buttons[start_row * GRID_SIZE + start_col + j].text = word[j]

func _on_button_pressed(button):
	# Add selected letter to the list and update feedback
	selected_letters.append(button.text)
	_check_word()

func _check_word():
	# Join selected letters to form a word and check if it’s in the list
	var selected_word = "".join(selected_letters)
	if selected_word in words_to_find:
		found_words_label.text += "Found: " + selected_word + "\n"
		words_to_find.erase(selected_word)
		selected_letters.clear()
	elif len(selected_letters) > GRID_SIZE:
		# Clear selections if word is too long and invalid
		selected_letters.clear()
