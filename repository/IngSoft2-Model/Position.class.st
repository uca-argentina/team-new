Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'lap',
		'space'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> atStart [
^ self on: 0 at: 1.
]

{ #category : #'instance creation' }
Position class >> on: aSpace at: aLap [
	^ self new initializeOn: aSpace at: aLap 
]

{ #category : #updating }
Position >> change: aSpace [

space:= aSpace.
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
Position >> initializeOn: aSpace at: aLap [
	lap := aLap.
	space := aSpace
]

{ #category : #updating }
Position >> update: aLap [
lap:= aLap.
]
