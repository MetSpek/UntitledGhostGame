extends CanvasLayer

func _ready():
	get_tree().paused = true
	set_inventory_items()
	set_storage_items()


func set_inventory_items():
	if GlobalStats.inventory[0] != null:
		$ItemStorage/InventoryContainer/Item1.visible = true
		$ItemStorage/InventoryContainer/Item1/ItemName.text = str(GlobalStats.inventory[0].item_name)
		$ItemStorage/InventoryContainer/Item1/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[0], 0, $ItemStorage/InventoryContainer/Item1])
		
	else:
		$ItemStorage/InventoryContainer/Item1.visible = false
	
	if GlobalStats.inventory[1] != null:
		$ItemStorage/InventoryContainer/Item2.visible = true
		$ItemStorage/InventoryContainer/Item2/ItemName.text = str(GlobalStats.inventory[1].item_name)
		$ItemStorage/InventoryContainer/Item2/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[1], 1, $ItemStorage/InventoryContainer/Item2])
	else:
		$ItemStorage/InventoryContainer/Item2.visible = false
	
	if GlobalStats.inventory[2] != null:
		$ItemStorage/InventoryContainer/Item3.visible = true
		$ItemStorage/InventoryContainer/Item3/ItemName.text = str(GlobalStats.inventory[2].item_name)
		$ItemStorage/InventoryContainer/Item3/Button.connect("pressed", self, "_on_Drop_Button_pressed", [GlobalStats.inventory[2], 2, $ItemStorage/InventoryContainer/Item3])
	else:
		$ItemStorage/InventoryContainer/Item3.visible = false

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
		$ItemStorage/StorageContainer/StorageScrollContainer/ItemContainer.add_child(item_node)


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
	$ItemStorage.visible = false
	get_tree().paused = false


func _on_Drop_Button_pressed(item, x, container):
	if item.has_method("drop"):
		container.visible = false
		item.drop(get_tree().get_root().get_node("LevelTemplate").get_node("PlayerCharacter").global_position)
		GlobalStats.inventory[x] = null
