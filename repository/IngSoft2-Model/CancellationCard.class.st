Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CancellationCard >> activateOne: aCard affecting: aPlayer on: aMatch [
	aMatch anulate: aCard affecting: aPlayer
]
