Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
Player class >> checkIsValid: aName [
	(aName matchesRegex: ' +')
		ifTrue: [ AssertionFailure signal: 'You can not create a player with no name' ]
]

{ #category : #'instance creation' }
Player class >> named: aName [
	self checkIsValid: aName.
	^ self new initializeWith: aName
]

{ #category : #initialization }
Player >> initializeWith: aName [
	name := aName
]

{ #category : #accesing }
Player >> name [
	^ name
]

{ #category : #playing }
Player >> throw: matchDices [
	^ matchDices sumNumbers: #roll
]

{ #category : #comparing }
Player >> value: aPlayer [
	^ self = aPlayer
]
