extends RefCounted

class_name Achievement
var title : String
var description : String
var progress : int

func _init(title_: String, description_: String, progress_: int):
	self.title = title_
	self.description = description_
	self.progress = progress_

