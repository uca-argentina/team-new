Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> activate: aCard affecting: aPlayer on: aMatch [
	aCard cancelAffecting: aPlayer on: aMatch
]
