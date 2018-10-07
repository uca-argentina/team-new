Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatingPlayerWithName [
	| martin |
	martin := Player named: 'Martin'.
	self assert: martin name equals: 'Martin'
]

{ #category : #tests }
PlayerTest >> testPlayerThrowsDices [
	| martin dice1 dice2 dice3 |
	martin := Player named: 'Martin'.
	dice1 := Dice deterministicWith: 4.
	dice2 := Dice deterministicWith: 5.
	dice3 := Dice deterministicWith: 6.
	self assert: martin name equals: 'Martin';
	     assert: (martin throw: {dice1.dice2.dice3}) equals: 3
]
