Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> withName: aName [
	^ self new initializeWithName: aName
]

{ #category : #playing }
Player >> countValueOfDicesRolled: theDices [
	^ theDices sumNumbers: [ :dice | dice roll ]
]

{ #category : #initialize }
Player >> initializeWithName: aName [
	name := aName
]

{ #category : #description }
Player >> name [
	^ name
]

{ #category : #playing }
Player >> throw: theDices [
	^ self countValueOfDicesRolled: theDices
]
