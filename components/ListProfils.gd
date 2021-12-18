extends PanelContainer

const Profil = preload("res://components/Carte.tscn");
export var canAdd = false;
var heroes = [];
var alchemists = [];
var troops = [];

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var lists = jsonService.get_faction(null);
	
	heroes = lists[0];
	alchemists = lists[1];
	troops = lists[2];
	
	var HNode = $"ScrollContainer/VBoxContainer/HeroesContainer";
	var ANode = $"ScrollContainer/VBoxContainer/AlchemistsContainer";
	var TNode = $"ScrollContainer/VBoxContainer/TroopsContainer";
	
	_createProfilList([heroes, HNode]);
	_createProfilList([alchemists, ANode]);
	_createProfilList([troops, TNode]);


# create the list displayed
# data [parent node, list, thread exit function signal]
func _createProfilList(data):
	var node = data[1];
	var list = data[0];
	for profil in list:
		yield(get_tree(), "idle_frame");
		var child = Profil.instance();
		child.name = profil["Nom"];
		node.call_deferred("add_child", child);
		yield(get_tree(), "idle_frame");
		child._setup(profil, canAdd);
		

