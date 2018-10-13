Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatingInvalidPlayer [
	| nicolas |
	self
		should: [ nicolas := Player named: '  ' ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'You can not create a player with no name' ]
]

{ #category : #tests }
PlayerTest >> testCreatingPlayerWithName [
	| martin |
	martin := Player named: 'Martin'.
	self assert: martin name equals: 'Martin'
]

{ #category : #tests }
PlayerTest >> testPlayerThrowsDices [
	| martin dices |
	martin := Player named: 'Martin'.
	dices := Array
		with: (Dice deterministicWith: 4 throwing: #(1 1 3))
		with: (Dice deterministicWith: 5 throwing: #(3 2 3))
		with: (Dice deterministicWith: 6 throwing: #(4 5 3)).
	self
		assert: martin name equals: 'Martin';
		assert: (martin throw: dices) equals: 8
]
