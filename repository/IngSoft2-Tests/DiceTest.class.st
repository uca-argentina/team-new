Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testCreatingRandomDiceWithAmountOfFacesNoValid [
	| dice |
	self
		should: [ dice := Dice randomWith: -3 ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a dice with less than 1 face' ]
]

{ #category : #tests }
DiceTest >> testDeterministicDiceRollsReturnExpectedNumber [
	| dice |
	dice := Dice deterministicWith: 4.
	self
		assert: dice roll equals: 1;
		assert: dice roll equals: 2;
		assert: dice roll equals: 3;
		assert: dice roll equals: 4;
		assert: dice roll equals: 1
]

{ #category : #tests }
DiceTest >> testDeterministicDiceRollsValidAmountAccordingToTheAmountOfFaces [
	| dice |
	dice := Dice deterministicWith: 3.
	self assert: dice roll <= 3
]

{ #category : #tests }
DiceTest >> testRandomDiceRollsAValidAmountAccordingToTheAmountOfFaces [
	| dice |
	dice := Dice deterministicWith: 6.
	self
		assert: (dice roll between: 1 and: 6);
		assert: (dice roll between: 1 and: 6);
		assert: (dice roll between: 1 and: 6);
		assert: (dice roll between: 1 and: 6);
		assert: (dice roll between: 1 and: 6)
]
