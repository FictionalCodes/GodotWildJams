extends Node

const FREE_BLOB_LAYER_INDEX := 2 
const STRUCTURE_BLOB_LAYER_INDEX := 4

enum BlobState
{
	Free = 1,
	PickedUp,
	Placed,
	Dead
}
