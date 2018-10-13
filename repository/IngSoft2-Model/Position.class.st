Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'lap',
		'space'
	],
	#category : #'IngSoft2-Model'
}

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
Position >> initialize [
	lap := 1.
	space := 0
]

{ #category : #updating }
Position >> update: aLap [
lap:= aLap.
]
