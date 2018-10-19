Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'spaces',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Board class >> boardOf: anAmountOfSpaces with: effectSuccession [
^ self new initializeWith: anAmountOfSpaces with: effectSuccession
]

{ #category : #'creation validation' }
Board class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> deterministicWith: anAmountOfSpaces with: effectSuccession [
	self checkIsValid: anAmountOfSpaces.
	^ self
		boardOf: anAmountOfSpaces
		with:
			(DeterministicBoardStrategy new
				generateEffectsWith: effectSuccession
				andBoardOf: anAmountOfSpaces)
]

{ #category : #'instance creation' }
Board class >> randomWith: anAmountOfSpaces [
	self checkIsValid: anAmountOfSpaces.
	^ self boardOf: anAmountOfSpaces with: ((RandomBoardStrategy new) generateEffectsWith: {  } andBoardOf: anAmountOfSpaces )
]

{ #category : #'game play' }
Board >> activateEffectOf: aSpace on: aGame activatedBy: aPlayer [
	^ (effects at: aSpace) turnOnEffectAt: aGame activatedBy: aPlayer
]

{ #category : #description }
Board >> effects [
^ effects
]

{ #category : #initialize }
Board >> initializeWith: anAmountOfSpaces with: effectSuccession [
	spaces := anAmountOfSpaces.
	effects := effectSuccession
]

{ #category : #description }
Board >> spaces [
	^ spaces
]
