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
CardBehavior >> assertingNextPlayerIn: aMatch is: aPlayer [
	self subclassResponsibility
]

{ #category : #applying }
CardBehavior >> canceledIn: aMatch [
	self subclassResponsibility
]

{ #category : #applying }
CardBehavior >> redoIn: aMatch to: aPlayer by: aRedoCard [
	self subclassResponsibility
]