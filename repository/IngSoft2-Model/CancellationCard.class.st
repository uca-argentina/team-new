Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CancellationCard >> activate: aCard affecting: aPlayer in: aMatch [
	aCard cancelAffecting: aPlayer on: aMatch.
	aMatch updateLastCard: self.
]

{ #category : #applying }
CancellationCard >> applyIn: aMatch to: aPlayer [
]
