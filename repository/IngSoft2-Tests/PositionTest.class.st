Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testComparingPositions [
	self assert: (Position on: 3 at: 5) >= (Position on: 15 at: 1)
]

{ #category : #tests }
PositionTest >> testCreatingPositionWithLapAndSpace [
	| position |
	position := Position atStart.
	self
		assert: position currentLap equals: 1;
		assert: position currentSpace equals: 0
]
