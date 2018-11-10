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

{ #category : #deactivation }
SpeedCard >> canceledIn: aMatch [
	aMatch removeActivated: self
]

{ #category : #applying }
SpeedCard >> redoIn: aMatch to: aPlayer by: aRedoCard [
	aMatch add: aRedoCard toBeAppliedTo: aPlayer.
	aMatch updateLastCard: aRedoCard
]

{ #category : #moving }
SpeedCard >> spacesToMove [
	^ 1
]
