Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#category : #'IngSoft2-Model'
}

{ #category : #moving }
AccelerationCard >> affectDiceRoll: aRoll [
	^ aRoll + 1
]

{ #category : #applying }
AccelerationCard >> applyIn: aMatch to: aPlayer [
	aMatch players do: [ :player | aMatch add: self toBeAppliedTo: player ].
	aMatch updateLastCard: self
]

{ #category : #applying }
AccelerationCard >> redoIn: aMatch to: aPlayer by:aRedoCard [
	aMatch players do: [ :player | aMatch add: aRedoCard toBeAppliedTo: player ].
	aMatch updateLastCard: aRedoCard
]
