Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountOfFaces',
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Dice class >> assertAmountOfFacesIsBiggerThanZero: aNumber [
	aNumber > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a dice with less than 1 face' ]
]

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
Dice class >> deterministicWithAmountOfFaces: aNumber [
	^ self withAmountOfFaces: aNumber diceType: DeterministicDice new
]

{ #category : #'instance creation' }
Dice class >> randomWith: anAmountOfFaces [
	^ self with: anAmountOfFaces of: RandomDice new
]

{ #category : #'instance creation' }
Dice class >> randomWithAmountOfFaces: aNumber [
	^ self withAmountOfFaces: aNumber diceType: RandomDice new
]

{ #category : #'instance creation' }
Dice class >> with: aNumber of: aDiceType [
	self checkIsValid: aNumber.
	^ self new initializeWith: aNumber of: aDiceType
]

{ #category : #'instance creation' }
Dice class >> withAmountOfFaces: aNumber diceType: aDiceType [
	self assertAmountOfFacesIsBiggerThanZero: aNumber.
	^ self new initializeWithAmountOfFaces: aNumber diceType: aDiceType
]

{ #category : #initialize }
Dice >> initializeWith: anInteger of: aDiceType [
	amountOfFaces := anInteger.
	type := aDiceType
]

{ #category : #'game play' }
Dice >> roll [
	^ type roll: amountOfFaces
]
