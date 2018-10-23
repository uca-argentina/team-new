Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame resetPlayersSpaces
]
