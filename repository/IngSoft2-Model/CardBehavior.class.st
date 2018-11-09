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
CardBehavior >> assertingNextPlayerIn: aNextPlayer is: aPlayer [
	self subclassResponsibility
]

{ #category : #applying }
CardBehavior >> cancelAffecting: aPlayer in: aMatch [
	self subclassResponsibility
]

{ #category : #applying }
CardBehavior >> redoIn: aMatch to: aPlayer by: aRedoCard [
	self subclassResponsibility
]
