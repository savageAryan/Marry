extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var bloodamount: Label = $bloodamount
func updateblood():
	animation_player.play("new_animation")
	bloodamount.text = str(Gamemanager.blood)
