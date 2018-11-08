Class {
	#name : #RedoCard,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RedoCard >> applyIn: aMatch to: aPlayer [
	(aMatch lastCard) applyIn: aMatch to: aPlayer
]

{ #category : #applying }
RedoCard >> applyTo: aCard affecting: aPlayer in: aMatch [ 
	aMatch lastCard applyTo: aCard affecting: aPlayer in: aMatch.
]

{ #category : #applying }
RedoCard >> needs: aPlayer toBeTurnOf: aPlayer2 [ 
	
]
