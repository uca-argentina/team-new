Class {
	#name : #InstantCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
InstantCard >> assertingNextPlayerIn: aMatch is: aPlayer [
	
]

{ #category : #applying }
InstantCard >> canceledIn: aMatch [ 
	MatchException signal: 'Cancellation card can only be used affecting a Permantent Card'.
]
