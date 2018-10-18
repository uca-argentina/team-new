Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreatingBoardWithAmountOfSpacesNoValid [
	| board|
	self
		should: [ board := Board with: -30 of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					AtomicBombEffect new}
				withBoardOf: -30).]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a board with less than 1 space' ]
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithRandomStrategy [
	| board |
	board := Board with: 5 of: (RandomBoardStrategy withBoardOf: 5).
	self assert: (board effects detect:[:effect| (effect respondsTo:#turnOnEffectAt:activatedBy:) not] ifNone:[true]).
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithValidAmountOfSpaces [
	| board |
	board := Board
		with: 30
		of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					AtomicBombEffect new}
				withBoardOf: 30).
	self assert: board spaces equals: 30
]
