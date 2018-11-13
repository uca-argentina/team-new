Class {
	#name : #InstantCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #description }
InstantCard >> assertingNextPlayerIn: aMatch is: aPlayer [
	
]

{ #category : #cancelling }
InstantCard >> cancelledIn: aMatch [ 
	MatchException signal: 'Cancellation card can only be used affecting a Permantent Card'.
]
