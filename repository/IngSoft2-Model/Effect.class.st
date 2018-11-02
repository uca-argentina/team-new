Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
Effect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch dealCardTo: aPlayer
]
