extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const titleHeight = 148;
const footerHeight = 70;

# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/VBoxContainer/Description/VarDescription".bbcode_text = "La formule cible deux figurines alliées à portée dont au moins une est dotée de la compétence Effrayant (X).";
	$"MarginContainer/VBoxContainer/Upgrade/VarAmélioraions".bbcode_text= "2 pierres pour une";
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
