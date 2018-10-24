Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreatingBoardWithInvalidAmountOfSpaces [
	| board |
	self
		should: [ board := Board
				deterministicWithSpaces: -30
				andEffectsGeneratedFrom:
					{NoEffect new.
					AtomicBombEffect new} ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a board with less than 1 space' ]
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithRandomStrategy [
	| board |
	board := Board randomWithSpaces: 50.
	self assert: (board effects detect:[:effect| (effect respondsTo:#turnOnEffectAt:activatedBy:) not] ifNone:[true]).
]

{ #category : #tests }
BoardTest >> testCreatingBoardWithValidAmountOfSpaces [
	| board |
	board := Board
		deterministicWithSpaces: 30
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	self assert: board spaces equals: 30
]
