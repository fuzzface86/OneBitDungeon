extends Control

func _ready():
	var hero = get_node("/root/Main/Hero") # Or use autoload
	$HeroName.text = "Name: %s" % hero.name
	$HeroLevel.text = "Level: %d" % hero.level
	$HeroXP.text = "XP: %d" % hero.xp
	$HeroGold.text = "Gold: %d" % hero.gold
	
	var inventory_list = $InventoryVBox
	inventory_list.clear()
	for item in hero.inventory:
		var label = Label.new()
		label.text = "- " + item
		inventory_list.add_child(label)
