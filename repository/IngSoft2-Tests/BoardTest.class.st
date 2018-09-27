Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreatingBoardWith30Spaces [
	|board|
	board := Board withAmountOfSpaces: 30.
	self assert: board spaces equals: 30.
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithMinus30SpacesFails [
	|board|
	self should: [board := Board withAmountOfSpaces: -30]raise: AssertionFailure withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a board with less than 1 space' ].
	
]
