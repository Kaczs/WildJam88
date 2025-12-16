extends AnimationPlayer

signal summon

func summon_now():
	summon.emit()
