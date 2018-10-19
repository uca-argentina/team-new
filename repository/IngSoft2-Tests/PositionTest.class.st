Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testComparingPositions [
	self assert: (Position on: 15 at: 1) <= (Position on: 20 at: 3)
]

{ #category : #tests }
PositionTest >> testCreatingPositionWithLapAndSpace [
	| position |
	position := Position atStart.
	self
		assert: position currentLap equals: 0;
		assert: position currentSpace equals: 1
]
