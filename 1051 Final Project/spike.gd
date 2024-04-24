extends Area2D


func _ready():
	body_entered.connect(self._on_body_entered)

func _on_body_entered(node):
	if node.has_method("kill"):
		node.kill()
		
func _process(_delta):
	pass
