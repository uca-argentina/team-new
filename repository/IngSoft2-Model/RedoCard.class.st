Class {
	#name : #RedoCard,
	#superclass : #CardBehavior,
	#instVars : [
		'behaviour'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoCard >> applyIn: aMatch to: aPlayerOrACard [
	behaviour := aMatch lastCard.
	behaviour redoIn: aMatch to: aPlayerOrACard by: self
]

{ #category : #description }
RedoCard >> assertingNextPlayerIn: aMatch is: aPlayer [ 
	
]

{ #category : #cancelling }
RedoCard >> cancelledIn: aMatch [ 
	behaviour cancelledIn: aMatch. 
]

{ #category : #initialization }
RedoCard >> initialize [
	behaviour := NoneCard new
]

{ #category : #applying }
RedoCard >> redoIn: aMatch to: aPlayerOrACard by: aRedoCard [
	behaviour redoIn: aMatch to: aPlayerOrACard by: aRedoCard
]

{ #category : #moving }
RedoCard >> spacesToMove [
	^ behaviour spacesToMove.
]
