Class {
	#name : #InstantCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #description }
InstantCard >> assertCanBePlayedBy: aPlayer in: aMatch [
	
]

{ #category : #cancelling }
InstantCard >> cancelledIn: aMatch [ 
	MatchException signal: 'Cancellation card can only be used affecting a Permantent Card'.
]
