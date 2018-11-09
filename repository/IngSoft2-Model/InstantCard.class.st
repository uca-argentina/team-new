Class {
	#name : #InstantCard,
	#superclass : #CardBehavior,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
InstantCard >> assertingNextPlayerOn: onMatch is: aPlayer [
	
]

{ #category : #applying }
InstantCard >> cancelAffecting: aPlayer on: aMatch [ 
	MatchException signal: 'Cancellation card can only be used affecting a Permantent Card'.
]
