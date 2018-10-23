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
	^ self on: 1 at: 0
]

{ #category : #'instance creation' }
Position class >> on: aSpace at: aLap [
	^ self new initializeOn: aSpace at: aLap 
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
Position >> adjustWith: aBoard andMatchLast: totalLaps [
	^ space >= aBoard spaces & (lap = (totalLaps - 1))
		ifTrue: [ Position on: aBoard spaces at: totalLaps - 1 ]
		ifFalse: [ Position on: (space - 1) % aBoard spaces + 1 at: lap + ((space - space sign) // aBoard spaces) ]
]

{ #category : #descriptions }
Position >> currentLap [
	^ lap
]

{ #category : #descriptions }
Position >> currentSpace [
	^ space
]

{ #category : #initialize }
Position >> initializeOn: aSpace at: aLap [
	lap := aLap.
	space := aSpace
]
