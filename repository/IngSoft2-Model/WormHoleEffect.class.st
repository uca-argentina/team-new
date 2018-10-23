Class {
	#name : #WormHoleEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame move: aPlayer back: 4
]
