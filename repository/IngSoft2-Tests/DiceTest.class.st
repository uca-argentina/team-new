Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testCreatingRandomDiceWithAmountOfFacesNoValid [
	| dice |
	self
		should: [ dice := Dice randomWithAmountOfFaces: -3 ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a dice with less than 1 face' ]
]

{ #category : #tests }
DiceTest >> testDeterministicDiceRollsReturnExpectedNumber [
	| dice |
	dice := Dice deterministicWithAmountOfFaces: 4.
	self assert: dice roll equals: 1
]

{ #category : #tests }
DiceTest >> testDeterministicDiceRollsValidAmountAccordingToTheAmountOfFaces [
	| dice |
	dice := Dice deterministicWithAmountOfFaces: 3.
	self assert: dice roll <= 3
]

{ #category : #tests }
DiceTest >> testRandomDiceRollsAValidAmountAccordingToTheAmountOfFaces [
	| dice |
	dice := Dice deterministicWithAmountOfFaces: 6.
	self assert: (dice roll between: 1 and: 6).
	self assert: (dice roll between: 1 and: 6).
	self assert: (dice roll between: 1 and: 6).
	self assert: (dice roll between: 1 and: 6).
	self assert: (dice roll between: 1 and: 6)
]
