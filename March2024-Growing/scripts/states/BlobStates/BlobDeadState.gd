class_name BlobDeadState extends BlobBaseState

func EnterState():
	ourBody.queue_free()
