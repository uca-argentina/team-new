Class {
	#name : #InstantCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
InstantCard >> assertingNextPlayerIn: aMatch is: aPlayer [
	
]

{ #category : #deactivation }
InstantCard >> canceledIn: aMatch [ 
	MatchException signal: 'Cancellation card can only be used affecting a Permantent Card'.
]
