Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
SpeedCard >> applyIn: aMatch to: aPlayer [
	aMatch add: self toBeAppliedTo: aPlayer.
	aMatch updateLastCard: self
]

{ #category : #applying }
SpeedCard >> cancelAffecting: aPlayer in: aMatch [
	aMatch remove: self affecting: aPlayer
]

{ #category : #applying }
SpeedCard >> redoIn: aMatch to: aPlayer by: aRedoCard [
	aMatch add: aRedoCard toBeAppliedTo: aPlayer.
	aMatch updateLastCard: aRedoCard
]

{ #category : #applying }
SpeedCard >> spacesToMove [
	^ 1
]
