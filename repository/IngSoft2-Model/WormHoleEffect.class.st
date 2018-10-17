Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	| newPosition |
	newPosition := (aGame positionOf: aPlayer) currentSpace - 4.
	(aGame playersPositions detect: [ :playerWithPosition | playerWithPosition key = aPlayer ])
		value: (aGame adjust: newPosition with: (aGame positionOf: aPlayer))
]
