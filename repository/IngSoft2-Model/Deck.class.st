Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'dealingCardStrategy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> assertIsEmpty: cardSuccession [
	cardSuccession isEmpty
		ifTrue: [ MatchException
				signal: 'The card succession must have at least one card' ]
]

{ #category : #'instance creation' }
Deck class >> deterministicWithCardSequence: cardSuccession [
	self assertIsEmpty: cardSuccession.
	^ self shuffledBy: (DeterministicDeckStrategy using: cardSuccession)
]

{ #category : #'instance creation' }
Deck class >> random [
	^ self shuffledBy: RandomDeckStrategy new
]

{ #category : #'instance creation' }
Deck class >> shuffledBy: aDeckStrategy [ 
	^ self new initializeWith: aDeckStrategy 
]

{ #category : #dealing }
Deck >> dealCard [
	^ dealingCardStrategy nextCard
]

{ #category : #initialization }
Deck >> initializeWith: aDeckStrategy [
	dealingCardStrategy := aDeckStrategy
]
