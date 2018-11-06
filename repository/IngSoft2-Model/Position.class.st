Class {
	#name : #Position,
	#superclass : #Magnitude,
	#instVars : [
		'lap',
		'space'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> atStart [
	^ self onSpace: 1 ofLap: 0
]

{ #category : #'creation validation' }
Position class >> checkIsValid: aSpace [
	aSpace = 0
		ifTrue: [ MatchException signal: 'you can not create a Position of space 0' ]
]

{ #category : #'instance creation' }
Position class >> onSpace: aSpace ofLap: aLap [
	self checkIsValid: aSpace.
	^ self new initializeOnSpace: aSpace ofLap: aLap
]

{ #category : #'instance creation' }
Position class >> whenMoving: anAmountOfSpaces from: aPosition onBoardOfSize: aBoardSize [
	| newSpaces newLap |
	newSpaces := (aPosition currentSpace + anAmountOfSpaces - 1) % aBoardSize + 1.
	newLap := aPosition currentLap + ((aPosition currentSpace + anAmountOfSpaces - 1) // aBoardSize).
	^ self onSpace: newSpaces ofLap: newLap
]

{ #category : #comparing }
Position >> < aPosition [
	^ self currentLap = aPosition currentLap
		ifTrue: [ self currentSpace < aPosition currentSpace ]
		ifFalse: [ self currentLap < aPosition currentLap ]
]

{ #category : #comparing }
Position >> = aPosition [
	^ self currentLap = aPosition currentLap
		ifTrue: [ self currentSpace = aPosition currentSpace ]
		ifFalse: [ self currentLap = aPosition currentLap ]
]

{ #category : #accessing }
Position >> currentLap [
	^ lap
]

{ #category : #accessing }
Position >> currentSpace [
	^ space
]

{ #category : #initialization }
Position >> initializeOnSpace: aSpace ofLap: aLap [
	lap := aLap.
	space := aSpace
]
