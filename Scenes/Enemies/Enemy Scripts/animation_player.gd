extends AnimationPlayer

signal summon

@onready var enemy:CharacterBody2D = $".."
var pos

func summon_now():
	summon.emit()

func move():
	pos = enemy.position
	self.play("RESET")
	self.advance(0)
	enemy.position = pos
