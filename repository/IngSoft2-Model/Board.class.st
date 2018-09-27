Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertAmountOfSpacesIsBiggerThanZero: aNumber [
	aNumber > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> withAmountOfSpaces: aNumber [
	self assertAmountOfSpacesIsBiggerThanZero: aNumber.
	^ self new initializeWithSpaces: aNumber
]

{ #category : #initialize }
Board >> initializeWithSpaces: anAmountOfSpaces [
	spaces := anAmountOfSpaces.
]

{ #category : #description }
Board >> spaces [
	^ spaces
]
