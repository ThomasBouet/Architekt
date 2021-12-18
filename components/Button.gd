extends PanelContainer

export var label : String;

func _ready():
	$"HBoxContainer/Label".text = label;
