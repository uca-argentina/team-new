Class {
	#name : #DeterministicDeckStrategy,
	#superclass : #DeterministicStrategy,
	#category : #'IngSoft2-Tests'
}

{ #category : #generating }
DeterministicDeckStrategy >> nextCard [
	index := index % sequence size + 1.
	^ sequence at: index
]
