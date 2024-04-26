extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(self._on_body_entered)

func _on_body_entered(node):
	if node.has_method("victory"):
		node.victory()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
