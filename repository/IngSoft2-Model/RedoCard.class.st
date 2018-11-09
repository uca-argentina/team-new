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
	behaviour:= aMatch lastCard.
	behaviour redoIn: aMatch to: aPlayer by:self.
]

{ #category : #applying }
RedoCard >> applyTo: aCard affecting: aPlayer in: aMatch [
	aMatch lastCard applyTo: aCard affecting: aPlayer in: aMatch
]

{ #category : #applying }
RedoCard >> assertingNextPlayerIn: aMatch is: aPlayer [ 
	
]

{ #category : #applying }
RedoCard >> cancelAffecting: aPlayer in: aMatch [ 
	behaviour cancelAffecting: aPlayer in: aMatch. 
]

{ #category : #intialization }
RedoCard >> initialize [
	behaviour := NoneCard new
]

{ #category : #applying }
RedoCard >> redoIn: aMatch to: aPlayer by: aRedoCard [
	behaviour redoIn: aMatch to: aPlayer by: aRedoCard
]

{ #category : #applying }
RedoCard >> spacesToMove [
	^ behaviour spacesToMove.
]
