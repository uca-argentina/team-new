Class {
	#name : #SpeedUpEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
SpeedUpEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame moveByEffectTo: aPlayer spaces: 4
]
