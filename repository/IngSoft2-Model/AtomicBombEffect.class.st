Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame playersPositions
		do:
			[ :playerPosition | playerPosition value: (Position on: 1 at: (aGame positionOf: aPlayer) currentLap) ]
]
