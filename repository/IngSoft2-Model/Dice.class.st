Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountOfFaces',
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
Dice class >> checkIsValid: anAmountOfFaces [
	anAmountOfFaces > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a dice with less than 1 face' ]
]

{ #category : #'instance creation' }
Dice class >> deterministicWith: anAmountOfFaces [
	^ self with: anAmountOfFaces of: DeterministicDice new
]

{ #category : #'instance creation' }
Dice class >> randomWith: anAmountOfFaces [
	^ self with: anAmountOfFaces of: RandomDice new
]

{ #category : #'instance creation' }
Dice class >> with: anAmountOfFaces of: aDiceType [
	self checkIsValid: anAmountOfFaces.
	^ self new initializeWith: anAmountOfFaces of: aDiceType
]

{ #category : #initialize }
Dice >> initializeWith: anAmountOfFaces of: aDiceType [
	amountOfFaces := anAmountOfFaces.
	type := aDiceType
]

{ #category : #'game play' }
Dice >> roll [
	^ type roll: amountOfFaces
]
