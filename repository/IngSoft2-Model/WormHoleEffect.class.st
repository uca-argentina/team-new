Class {
	#name : #WormHoleEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
WormHoleEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch moveByEffectTo: aPlayer spaces: 4 negated
]
