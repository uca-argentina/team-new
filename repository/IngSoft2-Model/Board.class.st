Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
Board class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'creation validation' }
Board class >> checkIsValidThrowing: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> with: anAmountOfSpaces [
	self checkIsValidThrowing: anAmountOfSpaces.
	^ self new initializeWith: anAmountOfSpaces
]

{ #category : #initialize }
Board >> initializeWith: anAmountOfSpaces [
	spaces := anAmountOfSpaces.
]

{ #category : #description }
Board >> spaces [
	^ spaces
]
