Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> named: aName [
	^ self new initializeWithName: aName
]

{ #category : #playing }
Player >> countValueOf: gameDices [
	^ gameDices sumNumbers: [ :dice | dice roll ]
]

{ #category : #initialize }
Player >> initializeWithName: aName [
	name := aName
]

{ #category : #accesing }
Player >> name [
	^ name
]

{ #category : #playing }
Player >> throw: gameDices [
	^ self countValueOf: gameDices
]
