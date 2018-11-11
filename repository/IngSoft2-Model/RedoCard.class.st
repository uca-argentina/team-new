Class {
	#name : #RedoCard,
	#superclass : #CardBehavior,
	#instVars : [
		'behaviour'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoCard >> applyIn: aMatch to: aPlayer [
	behaviour := aMatch lastCard.
	behaviour redoIn: aMatch to: aPlayer by: self
]

{ #category : #description }
RedoCard >> assertingNextPlayerIn: aMatch is: aPlayer [ 
	
]

{ #category : #cancelling }
RedoCard >> canceledIn: aMatch [ 
	behaviour canceledIn: aMatch. 
]

{ #category : #intialization }
RedoCard >> initialize [
	behaviour := NoneCard new
]

{ #category : #applying }
RedoCard >> redoIn: aMatch to: aPlayer by: aRedoCard [
	behaviour redoIn: aMatch to: aPlayer by: aRedoCard
]

{ #category : #moving }
RedoCard >> spacesToMove [
	^ behaviour spacesToMove.
]
