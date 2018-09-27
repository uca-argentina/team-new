Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountOfFaces',
		'typeOfDice'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Dice class >> assertAmountOfFacesIsBiggerThanZero: aNumber [
	aNumber > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a dice with less than 1 face' ]
]

{ #category : #'instance creation' }
Dice class >> deterministicWithAmountOfFaces: aNumber [
	^ self withAmountOfFaces: aNumber diceType: DeterministicDice new
]

{ #category : #'instance creation' }
Dice class >> randomWithAmountOfFaces: aNumber [
	^ self withAmountOfFaces: aNumber diceType: RandomDice new
]

{ #category : #'instance creation' }
Dice class >> withAmountOfFaces: aNumber diceType: aDiceType [
	self assertAmountOfFacesIsBiggerThanZero: aNumber.
	^ self new initializeWithAmountOfFaces: aNumber diceType: aDiceType
]

{ #category : #initialize }
Dice >> initializeWithAmountOfFaces: anInteger diceType: aDiceType [
	amountOfFaces := anInteger.
	typeOfDice := aDiceType
]

{ #category : #rolling }
Dice >> roll [
	^ typeOfDice roll: amountOfFaces
]
