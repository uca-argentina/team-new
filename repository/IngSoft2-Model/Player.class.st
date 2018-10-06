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
	^ self new initializeWith: aName
]

{ #category : #playing }
Player >> countValueOf: gameDices [
	^ gameDices sumNumbers: [ :dice | dice roll ]
]

{ #category : #initialize }
Player >> initializeWith: aName [
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
