Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
CancellationCard >> applyIn: aMatch to: aCard [
	aCard canceledIn: aMatch.
	aMatch updateLastCard: self
]

{ #category : #applying }
CancellationCard >> redoIn: aMatch to: aCard by: aRedoCard [ 
	aCard canceledIn: aMatch.
	aMatch updateLastCard: aRedoCard
]
