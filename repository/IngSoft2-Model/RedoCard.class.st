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
RedoCard >> needs: aPlayer ToBeTurnOf: aPlayer2 [ 
	
]
