Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	(aGame playersPositions detect: [ :playerPosition | playerPosition key = aPlayer ])
		value:
			((Position on: (aGame positionOf: aPlayer) currentSpace - 4 at: (aGame positionOf: aPlayer) currentLap)
		adjustGoingBackwardsWith: aGame board)
]
