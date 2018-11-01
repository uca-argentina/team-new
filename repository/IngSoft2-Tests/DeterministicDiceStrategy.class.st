Class {
	#name : #DeterministicDiceStrategy,
	#superclass : #DeterministicStrategy,
	#category : #'IngSoft2-Tests'
}

{ #category : #generating }
DeterministicDiceStrategy >> nextNumberUsing: anAmountOfFaces [
	index := index % sequence size + 1.
	^ sequence at: index
]
