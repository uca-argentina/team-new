Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatingPlayerWithName [
	| martin |
	martin := Player withName: 'Martin'.
	self assert: martin name equals: 'Martin'
]

{ #category : #tests }
PlayerTest >> testPlayerThrowsDices [
	| martin dice1 dice2 dice3 |
	martin := Player withName: 'Martin'.
	dice1 := Dice deterministicWithAmountOfFaces: 4.
	dice2 := Dice deterministicWithAmountOfFaces: 5.
	dice3 := Dice deterministicWithAmountOfFaces: 6.
	self assert: martin name equals: 'Martin'.
	self assert: (martin throw: {dice1.dice2.dice3}) equals: 3
]
