Class {
	#name : #Effect,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
Effect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	self subclassResponsibility
]
