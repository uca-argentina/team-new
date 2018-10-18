Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame
		adjustBackWards:
			((aGame playersPositions detect: [ :playerPosition | playerPosition key = aPlayer ])
				value:
					(Position
						on: (aGame positionOf: aPlayer) currentSpace - 4
						at: (aGame positionOf: aPlayer) currentLap))
]
