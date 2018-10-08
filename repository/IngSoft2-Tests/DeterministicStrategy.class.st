Class {
	#name : #DeterministicStrategy,
	#superclass : #Object,
	#instVars : [
		'value',
		'numberSequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicStrategy class >> withThrowing: sequence [
	^ self new initializeThrowing: sequence
]

{ #category : #'game play' }
DeterministicStrategy >> generateNumberUsing: anAmountOfFaces [
	value := value % numberSequence size + 1.
	^ numberSequence at: value
]

{ #category : #initialize }
DeterministicStrategy >> initializeThrowing: sequence [
	value := 0.
	numberSequence := sequence
]
