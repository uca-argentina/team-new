Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testAdjustPositionGoingBackwardsMoreThanOneLap [
	| board position |
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect}.
	position := Position onSpace: -16 ofLap: 1.
	position := position adjustWith: board andMatchLengthOf: 5.
	self
		assert: position currentSpace equals: 4;
		assert: position currentLap equals: -1
]

{ #category : #tests }
PositionTest >> testAdjustPositionGoingBackwardsOneLap [
	| board position |
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect}.
	position := Position onSpace: -4 ofLap: 2.
	position := position adjustWith: board andMatchLengthOf: 5.
	self
		assert: position currentSpace equals: 6;
		assert: position currentLap equals: 1
]

{ #category : #tests }
PositionTest >> testAdjustPositionWhenPlayerFinishesTheMatch [
	| position board |
	position := Position onSpace: 15 ofLap: 1.
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect}.
	position := position adjustWith: board andMatchLengthOf: 2.
	self
		assert: position currentSpace equals: 5;
		assert: position currentLap equals: 2
]

{ #category : #tests }
PositionTest >> testAdjustPositionWhenPlayerMovesForwardMoreThanOneLap [
	| position board |
	position := Position onSpace: 25 ofLap: 1.
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect}.
	position := position adjustWith: board andMatchLengthOf: 5.
	self
		assert: position currentSpace equals: 5;
		assert: position currentLap equals: 3
]

{ #category : #tests }
PositionTest >> testAdjustPositionWhenPlayerMovesForwardOneLap [
	| position board |
	position := Position onSpace: 14 ofLap: 1.
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect}.
	position := position adjustWith: board andMatchLengthOf: 3.
	self
		assert: position currentSpace equals: 4;
		assert: position currentLap equals: 2
]

{ #category : #tests }
PositionTest >> testComparingPositionsWithEqualsOperator [
	self assert: (Position onSpace: 17 ofLap: 3) = (Position onSpace: 17 ofLap: 3)
]

{ #category : #tests }
PositionTest >> testComparingPositionsWithLowerThanOperator [
	self assert: (Position onSpace: 15 ofLap: 1) < (Position onSpace: 20 ofLap: 3)
]

{ #category : #tests }
PositionTest >> testCreatingPositionAtStartOfTheMatch [
	| position |
	position := Position atStart.
	self
		assert: position currentLap equals: 0;
		assert: position currentSpace equals: 1
]

{ #category : #tests }
PositionTest >> testCreatingPositionWithInvalidSpace [
	| position |
	self
		should: [ position := Position onSpace: 0 ofLap: 12 ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a Position of space 0' ]
]

{ #category : #tests }
PositionTest >> testCreatingPositionWithLapAndSpace [
	| position |
	position := Position onSpace: 26 ofLap: 12.
	self
		assert: position currentLap equals: 12;
		assert: position currentSpace equals: 26
]
