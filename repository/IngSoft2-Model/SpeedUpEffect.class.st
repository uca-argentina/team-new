Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
SpeedUpEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	| newPosition |
	newPosition := Position
		on: (aGame positionOf: aPlayer) currentSpace + 4
		at: (aGame positionOf: aPlayer) currentLap.
	aGame playersPositions at:aPlayer put: (newPosition adjustWith: aGame board andMatchLast: aGame totalLaps)

]
