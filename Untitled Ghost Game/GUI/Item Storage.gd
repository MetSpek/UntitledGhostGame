extends Popup

func _ready():
	set_storage_items()
	set_bullet_types()

func open_storage():
	get_tree().paused = true
	set_inventory_items()
	popup()

func set_inventory_items():
	if GlobalStats.inventory[0] != null:
		$Control/InventoryContainer/Item1.visible = true
		$Control/InventoryContainer/Item1/ItemName.text = str(GlobalStats.inventory[0].item_name)
		$Control/InventoryContainer/Item1/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[0], 0, $Control/InventoryContainer/Item1])
		
	else:
		$Control/InventoryContainer/Item1.visible = false
	
	if GlobalStats.inventory[1] != null:
		$Control/InventoryContainer/Item2.visible = true
		$Control/InventoryContainer/Item2/ItemName.text = str(GlobalStats.inventory[1].item_name)
		$Control/InventoryContainer/Item2/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[1], 1, $Control/InventoryContainer/Item2])
	else:
		$Control/InventoryContainer/Item2.visible = false
	
	if GlobalStats.inventory[2] != null:
		$Control/InventoryContainer/Item3.visible = true
		$Control/InventoryContainer/Item3/ItemName.text = str(GlobalStats.inventory[2].item_name)
		$Control/InventoryContainer/Item3/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[2], 2, $Control/InventoryContainer/Item3])
	else:
		$Control/InventoryContainer/Item3.visible = false

func set_storage_items():
	for x in GlobalStats.item_list.size():
		var item_node = HBoxContainer.new()
		var item_name = Label.new()
		var item_button = Button.new()
		item_node.name = "Storage" + str(GlobalStats.item_list[x].name)
		item_node.set("custom_constants/separation", 20)
		item_node.alignment = BoxContainer.ALIGN_END
		item_name.text = GlobalStats.item_list[x].name
		item_name.grow_horizontal = Control.GROW_DIRECTION_BEGIN
		item_button.text = "Take"
		item_button.rect_min_size.x = 100
		item_button.connect("pressed", self, "_on_Button_pressed", [GlobalStats.item_list[x].source, item_node])
		item_node.add_child(item_name)
		item_node.add_child(item_button)
		$Control/StorageContainer/StorageScrollContainer/ItemContainer.add_child(item_node)

func set_bullet_types():
	for x in GlobalGameHandler.all_bullet_types:
		$Control/BulletButton.add_item(x)

func _on_Button_pressed(item, node):
	add_to_inventory(item, node)

func add_to_inventory(item, node):
	var item_to_load = load(item)
	var item_to_add = item_to_load.instance()
	for x in GlobalStats.inventory.size():
		if GlobalStats.inventory[x] == null:
			GlobalStats.inventory[x] = item_to_add
			get_tree().get_root().get_node("LevelTemplate").get_node("PlayerCharacter").get_node("Inventory").add_child(item_to_add)
			get_tree().get_root().get_node("LevelTemplate").get_node("PlayerCharacter").switch_holding("stay")
			node.visible = false
			break;
	set_inventory_items()


func _on_CloseButton_pressed():
	hide()
	get_tree().paused = false


func _on_Drop_Button_pressed(item, x, container):
	if item.has_method("drop"):
		container.visible = false
		item.drop(get_tree().get_root().get_node("LevelTemplate").get_node("PlayerCharacter").global_position)
		GlobalStats.inventory[x] = null


func _on_ReloadAmmo_button_up():
	GlobalStats.bullet_amount = 240
	get_tree().call_group("BulletCount", "update_bullet_count")




func _on_BulletButton_item_selected(index):
	GlobalStats.type_bullet = GlobalGameHandler.all_bullet_types[index]
