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
Board class >> boardOf: anAmountOfSpaces with: aBoardStrategy [
	^ self new initializeWith: anAmountOfSpaces and: aBoardStrategy
]

{ #category : #'creation validation' }
Board class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> deterministicWithSpaces: anAmountOfSpaces andEffectsGeneratedFrom: effectSuccession [
	self checkIsValid: anAmountOfSpaces.
	^ self
		boardOf: anAmountOfSpaces
		with:
			(DeterministicBoardStrategy using: effectSuccession  )
]

{ #category : #'instance creation' }
Board class >> randomWithSpaces: anAmountOfSpaces [
	self checkIsValid: anAmountOfSpaces.
	^ self boardOf: anAmountOfSpaces with: RandomBoardStrategy new
]

{ #category : #'game play' }
Board >> applyEffectOf: aSpace on: aMatch activatedBy: aPlayer [
	aMatch updateLastEffect: aPlayer->(effects at: aSpace).
	^ (effects at: aSpace) turnOnEffectAt: aMatch activatedBy: aPlayer
]

{ #category : #accessing }
Board >> effects [
	^ effects
]

{ #category : #initialization }
Board >> initializeWith: anAmountOfSpaces and: aBoardStrategy [
	spaces := anAmountOfSpaces.
	effects := (1 to: anAmountOfSpaces) collect: [ :i | aBoardStrategy nextEffect ]
]

{ #category : #accessing }
Board >> spaces [
	^ spaces
]
