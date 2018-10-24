Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch resetPlayersSpaces
]
