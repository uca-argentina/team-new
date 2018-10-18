Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces',
		'boardStrategy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
Board class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> with: anAmountOfSpaces of: aBoardStrategy [
	self checkIsValid: anAmountOfSpaces.
	^ self new initializeWith: anAmountOfSpaces of: aBoardStrategy 
]

{ #category : #'game play' }
Board >> activateEffectOf: aSpace on: aGame activatedBy: aPlayer [
	^ (boardStrategy effects at: aSpace) turnOnEffectAt: aGame activatedBy: aPlayer
]

{ #category : #description }
Board >> effects [
^ boardStrategy effects
]

{ #category : #initialize }
Board >> initializeWith: anAmountOfSpaces of: aBoardStrategy [
	spaces := anAmountOfSpaces.
	boardStrategy := aBoardStrategy
	
]

{ #category : #description }
Board >> spaces [
	^ spaces
]
