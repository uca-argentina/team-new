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
		ifTrue: [ AssertionFailure signal: 'you can not create a Position of space 0' ]
]

{ #category : #'instance creation' }
Position class >> onSpace: aSpace ofLap: aLap [
	self checkIsValid: aSpace.
	^ self new initializeOnSpace: aSpace ofLap: aLap
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

{ #category : #playing }
Position >> adjustWith: aBoard andMatchLengthOf: totalLaps [
	^ (space >= aBoard spaces and: lap = (totalLaps - 1))
		ifTrue: [ Position onSpace: aBoard spaces ofLap: totalLaps - 1 ]
		ifFalse: [ Position onSpace: (space - 1) % aBoard spaces + 1 ofLap: lap + ((space - 1) // aBoard spaces) ]
]

{ #category : #descriptions }
Position >> currentLap [
	^ lap
]

{ #category : #descriptions }
Position >> currentSpace [
	^ space
]

{ #category : #initialization }
Position >> initializeOnSpace: aSpace ofLap: aLap [
	lap := aLap.
	space := aSpace
]
