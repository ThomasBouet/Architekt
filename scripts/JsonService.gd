extends Node

var _profils_dict;
var profilsMapKeys = [];
var all_profils_array = [];

enum factions {AURLOK, WAGA, WALOSI, AVALON, SANCTIFIES, TEMPLE, CARTEL, EVADES, KHALIMAN, SORORITE, LOGES, NAASHTI, RADOS, TRIADE_DE_JADE, GARDE_COBRA, UTOPIE}
var types = {TROOP = "Troupe", HERO = "Héro", HERO_ALCHEMIST = "Héro/Alchimiste", ALCHEMIST = "Alchimiste", SPECIAL = "Spécial"}

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_map();
	all_profils_array = get_faction(null);
	pass # Replace with function body.

#set the profils_map with the value contained in the json file
func _set_map():
	var profils = File.new();
	profils.open("res://ressources/profils.json", File.READ);
	var profils_list = JSON.parse(profils.get_as_text()).result;
	profils.close();
	_profils_dict = profils_list;
	pass;
	
func get_profils_keys():
	return _profils_dict.keys();
	
func get_faction(var faction):
	match faction:
		factions.AURLOK:
			return get_profils_list(_profils_dict["Aurlock"]);
		factions.AVALON:
			return get_profils_list(_profils_dict["Avalon"]);
		factions.CARTEL: 
			return get_profils_list(_profils_dict["Cartel"]);
		factions.EVADES:
			return get_profils_list(_profils_dict["Evades"]);
		factions.GARDE_COBRA:
			return get_profils_list(_profils_dict["Garde Cobra"]);
		factions.KHALIMAN:
			return get_profils_list(_profils_dict["Khaliman"]);
		factions.LOGES:
			return get_profils_list(_profils_dict["Loges"]);
		factions.NAASHTI:
			return get_profils_list(_profils_dict["Naashti"]);
		factions.RADOS:
			return get_profils_list(_profils_dict["Rados"]);
		factions.SANCTIFIES:
			return get_profils_list(_profils_dict["Sanctifies"]);
		factions.SORORITE:
			return get_profils_list(_profils_dict["Sororite"]);
		factions.TEMPLE:
			return get_profils_list(_profils_dict["Temple"]);
		factions.TRIADE_DE_JADE:
			return get_profils_list(_profils_dict["Triade de Jade"]);
		factions.UTOPIE:
			return get_profils_list(_profils_dict["Utopie"]);
		factions.WAGA:
			return get_profils_list(_profils_dict["Waga"]);
		factions.WALOSI:
			return get_profils_list(_profils_dict["Walosi"]);
		_:
			return get_profils_list(_get_all_profils());
			
func _get_all_profils():
	var global_array = [];
	for k in get_profils_keys():
		global_array += _profils_dict[k];
	global_array.sort_custom(ProfilsSorter, "sort_by_ID");
	var uniq_array = [];
	var ids_array = [];
	for p in global_array:
		if not ids_array.has(p["ID"]):
			ids_array.append(p["ID"]);
			uniq_array.append(p);
	return uniq_array;
	
func get_profils_list(list):
	var heroes = [];
	var alchemists = [];
	var troops = [];
	for p in list:
		match p["Type"]:
			types.HERO:
				heroes.append(p);
			types.HERO_ALCHEMIST:
				heroes.append(p);
			types.ALCHEMIST:
				alchemists.append(p);
			types.TROOP:
				troops.append(p);
			types.SPECIAL:
				troops.append(p);
			_:
				troops.append(p);
	return [heroes, alchemists, troops];

class ProfilsSorter:
	static func sort_by_ID(a, b):
		if a["ID"] < b["ID"]:
			return true
		return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
