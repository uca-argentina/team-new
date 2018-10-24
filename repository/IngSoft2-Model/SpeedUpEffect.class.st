Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
SpeedUpEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch moveByEffectTo: aPlayer spaces: 4
]
