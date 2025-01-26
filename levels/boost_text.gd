extends Label

@onready var boost_text: Label = $"../BoostText"

func show_boost_text():
	boost_text.show()
	print("text shown!")
