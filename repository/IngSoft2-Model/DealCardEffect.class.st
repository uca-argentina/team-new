Class {
	#name : #DealCardEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
DealCardEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch dealCardTo: aPlayer
]
