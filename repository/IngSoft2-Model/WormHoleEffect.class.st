Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame moveByEffectTo: aPlayer spaces: 4 negated
]
