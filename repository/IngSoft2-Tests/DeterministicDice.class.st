Class {
	#name : #DeterministicDice,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialize }
DeterministicDice >> initialize [
	value := 0
]

{ #category : #'game play' }
DeterministicDice >> roll: anAmountOfFaces [
	value:= (value%anAmountOfFaces)+1.
	^ (value)
]
