Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreatingBoardWithAmountOfSpacesNoValid [
	| board |
	self
		should: [ board := Board has: -30 ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a board with less than 1 space' ]
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithValidAmountOfSpaces [
	| board |
	board := Board has: 30.
	self assert: board spaces equals: 30
]
