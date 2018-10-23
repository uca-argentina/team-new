Class {
	#name : #AtomicBombEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	"aGame players do:
			[ :player| aGame playersPositions at:player put: (Position on: 1 at: (aGame playersPositions at:player )currentLap) ]"
		aGame resetOnlyPositionOfAllThePlayers 
]
