Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame playersPositions
		do: [ :each | each value: (Position on: 0 at: (aGame positionOf: aPlayer) currentLap) ]
]
