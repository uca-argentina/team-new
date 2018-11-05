Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountOfFaces',
		'rollingStrategy'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
Dice class >> checkIsValid: anAmountOfFaces [
	anAmountOfFaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a dice with less than 1 face' ]
]

{ #category : #'creation validation' }
Dice class >> checkIsValidThrowing: sequence with: anAmountOfFaces [
	sequence detect: [ :aNumber | aNumber > anAmountOfFaces ] ifFound: [ AssertionFailure signal: 'The sequence can not have a number bigger than amount of faces' ]
]

{ #category : #'instance creation' }
Dice class >> deterministicWithFaces: anAmountOfFaces throwing: sequence [
	self checkIsValid: anAmountOfFaces.
	self checkIsValidThrowing: sequence with: anAmountOfFaces.
	^ self with: anAmountOfFaces of: (DeterministicDiceStrategy using: sequence)
]

{ #category : #'instance creation' }
Dice class >> randomWithFaces: anAmountOfFaces [
	self checkIsValid: anAmountOfFaces.
	^ self with: anAmountOfFaces of: RandomDiceStrategy new
]

{ #category : #'instance creation' }
Dice class >> with: anAmountOfFaces of: aRollingStrategy [
	^ self new initializeWith: anAmountOfFaces of: aRollingStrategy
]

{ #category : #initialization }
Dice >> initializeWith: anAmountOfFaces of: aStrategyType [
	amountOfFaces := anAmountOfFaces.
	rollingStrategy := aStrategyType
]

{ #category : #'game play' }
Dice >> roll [
	^ rollingStrategy nextNumberUsing: amountOfFaces
]
