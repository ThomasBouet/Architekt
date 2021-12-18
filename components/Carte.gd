extends PanelContainer


var bodyVisible = false;
var maxNumber = 0;
var imgName;
var shouldInverse = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _setup(profil, canAdd):
	# configure the header of the card display
	# upper part
	$"MarginContainer/VBoxContainer/Header/PanelContainer/HBoxContainer/BriefSummary/UpperPart/Name".text = profil["Nom"];
	$"MarginContainer/VBoxContainer/Header/PanelContainer/HBoxContainer/BriefSummary/UpperPart/Cost".text = profil["Cout"];
	# lower part
	$"MarginContainer/VBoxContainer/Header/PanelContainer/HBoxContainer/BriefSummary/LowerPart/PA/Label".text = profil["PA"]; 
	$"MarginContainer/VBoxContainer/Header/PanelContainer/HBoxContainer/BriefSummary/LowerPart/Number".text = "";
	
	# display the correct triangle
	var health = profil["Vie"].split("/");
	call_deferred("_init_healthBar", health);
	
	# hide or not the button
	maxNumber = int(profil["Max"]);
	if (!canAdd || maxNumber == 0):
		$"MarginContainer/VBoxContainer/Header/AddButton".visible = false;
		$"MarginContainer/VBoxContainer/Header/RemoveButton".visible = false;
	
	# configure the body of the card display
	# stats
	$"MarginContainer/VBoxContainer/Body/Stats/COM/HBoxContainer/TextureRect/Value".text = profil["Cbt"];
	$"MarginContainer/VBoxContainer/Body/Stats/ESP/HBoxContainer/TextureRect/Value".text = profil["Esp"];
	$"MarginContainer/VBoxContainer/Body/Stats/DEF/HBoxContainer/TextureRect/Value".text = profil["Def"];
	$"MarginContainer/VBoxContainer/Body/Stats/REF/HBoxContainer/TextureRect/Value".text = profil["Ref"];
	
	# movements
	var mvt = profil["Mvt"].split("/");
	$"MarginContainer/VBoxContainer/Body/Mouvements/Marche/HBoxContainer/Value".text = mvt[0];
	$"MarginContainer/VBoxContainer/Body/Mouvements/Charge/HBoxContainer/Value".text = mvt[1];
	$"MarginContainer/VBoxContainer/Body/Mouvements/Course/HBoxContainer/Value".text = mvt[2];
	
	# competence
	var comp = profil["Compétences"].replace("/","\r\n") if profil["Compétences"].find("-") == -1 else "";
	$"MarginContainer/VBoxContainer/Body/CompétencesFormules/Competence/Value".bbcode_text = comp;
	if (comp == ""):
		$"MarginContainer/VBoxContainer/Body/CompétencesFormules/Competence".visible = false;
	
	# formule
	var form = profil["Compétences"].replace("/","\r\n") if !profil["Compétences"].find("-") == -1 else "";
	$"MarginContainer/VBoxContainer/Body/CompétencesFormules/Formules/Value".bbcode_text = form;
	if (form == ""):
		$"MarginContainer/VBoxContainer/Body/CompétencesFormules/Formules".visible = false; 
		
	imgName = profil["Imgs"];
	pass;

# display the health bar of each profil correctly
func _init_healthBar(list):
	var node = $"MarginContainer/VBoxContainer/Header/PanelContainer/HBoxContainer/BriefSummary/LowerPart/HealthBar";
	var whites = int(list[0]);
	var yellows = int(list[1]);
	var reds = int(list[2]);
	
	for i in whites:
		yield(get_tree(), "idle_frame");
		var triangle = TextureRect.new();
		yield(get_tree(), "idle_frame");
		triangle.set_texture(load("res://textures/components/header/white.png"));
		triangle.set_flip_v(shouldInverse);
		shouldInverse = !shouldInverse;
		triangle.expand = true;
		triangle.stretch_mode = TextureRect.STRETCH_KEEP;
		triangle.rect_min_size.x = 20;
		node.add_child(triangle);
	
	for i in yellows:
		yield(get_tree(), "idle_frame");
		var triangle = TextureRect.new();
		yield(get_tree(), "idle_frame");
		triangle.set_texture(load("res://textures/components/header/yellow.png"));
		triangle.set_flip_v(shouldInverse);
		shouldInverse = !shouldInverse;
		triangle.expand = true;
		triangle.stretch_mode = TextureRect.STRETCH_KEEP;
		triangle.rect_min_size.x = 20;
		node.add_child(triangle);
		
	for i in reds:
		yield(get_tree(), "idle_frame");
		var triangle = TextureRect.new();
		yield(get_tree(), "idle_frame");
		triangle.set_texture(load("res://textures/components/header/red.png"));
		triangle.set_flip_v(shouldInverse);
		shouldInverse = !shouldInverse;
		triangle.expand = true;
		triangle.stretch_mode = TextureRect.STRETCH_KEEP;
		triangle.rect_min_size.x = 20;
		node.add_child(triangle);

	node.get_child(node.get_child_count() - 1).rect_min_size.x = 32;
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
