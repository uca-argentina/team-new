Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #Object,
	#instVars : [
		'typeOfEffects'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicBoardStrategy class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
DeterministicBoardStrategy class >> with: effectSuccession withBoardOf: anAmountOfSpaces [
	self checkIsValid: anAmountOfSpaces.
	^ self new initializeWith: effectSuccession withBoardOf: anAmountOfSpaces
]

{ #category : #description }
DeterministicBoardStrategy >> effects [
^ typeOfEffects.
]

{ #category : #initialze }
DeterministicBoardStrategy >> initializeWith: effectSuccession withBoardOf: anAmountOfSpaces [
	typeOfEffects := Array new: anAmountOfSpaces.
	(1 to: anAmountOfSpaces - 1)
		do: [ :space | typeOfEffects at: space put: (effectSuccession at: space % effectSuccession size + 1) ].
	typeOfEffects at: anAmountOfSpaces put: NoEffect new.
]
