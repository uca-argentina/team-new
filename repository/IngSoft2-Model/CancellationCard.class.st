Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CancellationCard >> applyTo: aCard affecting: aPlayer in: aMatch [
	aCard cancelAffecting: aPlayer on: aMatch.
	aMatch updateLastCard: self.
]
