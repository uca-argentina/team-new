Class {
	#name : #SpeedUpEffect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
SpeedUpEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	aGame move: aPlayer forward: 4.
	
]
