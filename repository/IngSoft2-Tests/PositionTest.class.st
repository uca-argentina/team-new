Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

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

{ #category : #tests }
PositionTest >> testCreatingValidPositionGoingBackwardsMoreThanOneLap [
	| position |
	position := Position
		whenMoving: -16
		from: (Position onSpace: 5 ofLap: 1)
		onBoardOfSize: 10.
	self
		assert: position currentSpace equals: 9;
		assert: position currentLap equals: -1
]

{ #category : #tests }
PositionTest >> testCreatingValidPositionGoingBackwardsOneLap [
	| position |
	position := Position whenMoving: -7 from: (Position onSpace: 3 ofLap: 2 ) onBoardOfSize: 10.
	self
		assert: position currentSpace equals: 6;
		assert: position currentLap equals: 1
]

{ #category : #tests }
PositionTest >> testCreatingValidPositionMovingForwardMoreThanOneLap [
	| position |
	position := Position whenMoving: 20 from: (Position onSpace: 5 ofLap: 1) onBoardOfSize: 10.
	self
		assert: position currentSpace equals: 5;
		assert: position currentLap equals: 3
]

{ #category : #tests }
PositionTest >> testCreatingValidPositionMovingForwardOneLap [
	| position |
	position := Position whenMoving: 8 from: (Position onSpace: 6 ofLap: 0) onBoardOfSize: 10.
	self
		assert: position currentSpace equals: 4;
		assert: position currentLap equals: 1
]

{ #category : #tests }
PositionTest >> testSpaceWillNotBe0IfGoingBackwards [
| position |
	position := Position whenMoving: -7 from: (Position onSpace: 7 ofLap: 2 ) onBoardOfSize: 10.
	self
		assert: position currentSpace equals: 10;
		assert: position currentLap equals: 1
]
