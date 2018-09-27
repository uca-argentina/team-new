Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatingPlayerWithNameMartin [
	| player  |
	player := Player withName: 'Martin'.
	self assert: player name equals: 'Martin'
]

{ #category : #tests }
PlayerTest >> testPlayerThrowsThreeDicesAndOutcomes3 [
| player  dice1 dice2 dice3|
	player := Player withName: 'Martin'.
	dice1 := Dice deterministicWithAmountOfFaces: 4.
	dice2 := Dice deterministicWithAmountOfFaces: 5.
	dice3 := Dice deterministicWithAmountOfFaces: 6.
	self assert: player name equals: 'Martin'.
	self assert: (player throw: { dice1.dice2.dice3 } )equals: 3.
]
