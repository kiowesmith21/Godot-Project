extends TextureRect

onready var itemTexture = $Icon

func display_item(item):
	if item is Item:
		itemTexture.texture = item.texture
