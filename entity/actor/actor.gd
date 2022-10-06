extends Entity

class_name Actor

var health:int
var title:String

func update_health(amount, title):
	print(health)
	health += amount
	title = title
	print(health)
