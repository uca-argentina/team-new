Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
Card >> applyIn: aMatch to: aPlayer [
	self subclassResponsibility
]

{ #category : #applying }
Card >> needs: aNextPlayer ToBeTurnOf: anAffecterPlayer [
	self subclassResponsibility
]
