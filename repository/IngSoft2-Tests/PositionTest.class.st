Class {
	#name : #PositionTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PositionTest >> testCreatingPositionWithLapAndSpace [
	| position |
	position := Position new.
	self
		assert: position currentLap equals: 1;
		assert: position currentSpace equals: 0
]
