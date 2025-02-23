extends Camera2D

@onready var fruit_sprites = { }
func _ready() -> void:
	fruit_sprites = {
	"1" : $"FruitUI/01",
	"2" : $"FruitUI/2",
	"3" : $"FruitUI/3",
	"4" : $"FruitUI/4",
	"5" : $"FruitUI/5",
	"6" : $"FruitUI/6",
	"7" : $"FruitUI/7",
	"8" : $"FruitUI/8",
	"9" : $"FruitUI/9",
	"10" : $"FruitUI/10"
	}

func _process(_delta):
	for fruit in fruit_sprites.keys():
		if PlayerProperties.fruits_collected[fruit]:
			fruit_sprites[fruit].modulate = Color(1,1,1,1)
		else:
			fruit_sprites[fruit].modulate = Color(0,0,0,1)
		
	
