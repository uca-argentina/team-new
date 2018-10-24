Class {
	#name : #DeterministicDiceStrategy,
	#superclass : #Object,
	#instVars : [
		'value',
		'numberSequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicDiceStrategy class >> withThrowing: sequence [
	^ self new initializeThrowing: sequence
]

{ #category : #generating }
DeterministicDiceStrategy >> generateNumberUsing: anAmountOfFaces [
	value := value % numberSequence size + 1.
	^ numberSequence at: value
]

{ #category : #initialize }
DeterministicDiceStrategy >> initializeThrowing: sequence [
	value := 0.
	numberSequence := sequence
]
