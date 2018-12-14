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
Board class >> assertIsEmpty: effectSuccession [
	effectSuccession isEmpty
		ifTrue: [ MatchException
				signal: 'The effect succession must have at least one effect' ]
]

{ #category : #'instance creation' }
Board class >> boardOf: anAmountOfSpaces with: aBoardStrategy [
	^ self new initializeWith: anAmountOfSpaces and: aBoardStrategy
]

{ #category : #'creation validation' }
Board class >> checkIsValid: anAmountOfSpaces [
	anAmountOfSpaces > 0
		ifFalse: [ MatchException signal: 'you can not create a board with less than 1 space' ]
]

{ #category : #'instance creation' }
Board class >> withRandomEffectsAndSpaces: anAmountOfSpaces [
	self checkIsValid: anAmountOfSpaces.
	^ self boardOf: anAmountOfSpaces with: RandomEffectProvidingStrategy new
]

{ #category : #'instance creation' }
Board class >> withSpaces: anAmountOfSpaces andDeterministicEffectsGeneratedFrom: effectSuccession [
	self assertIsEmpty: effectSuccession.
	self checkIsValid: anAmountOfSpaces.
	^ self
		boardOf: anAmountOfSpaces
		with: (DeterministicEffectProvidingStrategy using: effectSuccession)
]

{ #category : #'game play' }
Board >> applyEffectOf: aSpace in: aMatch activatedBy: aPlayer [
	aMatch updateLastEffect: aPlayer -> (effects at: aSpace).
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
