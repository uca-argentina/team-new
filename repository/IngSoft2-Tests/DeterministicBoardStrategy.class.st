Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #DeterministicStrategy,
	#category : #'IngSoft2-Tests'
}

{ #category : #generating }
DeterministicBoardStrategy >> nextEffect [
	index := index % sequence size + 1.
	^ sequence at: index
]
