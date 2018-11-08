Class {
	#name : #CardBehavior,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CardBehavior >> applyIn: aMatch to: aPlayer [
	self subclassResponsibility
]

{ #category : #applying }
CardBehavior >> asserting: aPlayer isHisTurnOn: aNextPlayer [
	self subclassResponsibility
]
