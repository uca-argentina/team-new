Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CancellationCard >> applyTo: aCard affecting: aPlayer in: aMatch [
	aCard cancelAffecting: aPlayer in: aMatch.
	aMatch updateLastCard: self
]
