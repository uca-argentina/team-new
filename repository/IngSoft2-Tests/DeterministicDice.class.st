Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'value',
		'numberSequence'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicDice class >> withThrowing: sequence [
	^ self new initializeThrowing: sequence
]

{ #category : #initialize }
DeterministicDice >> initializeThrowing: sequence [
	value := 0.
	numberSequence := sequence
]

{ #category : #'game play' }
DeterministicDice >> roll: anAmountOfFaces [
	value := value % numberSequence size + 1.
	^ numberSequence at: value
]
