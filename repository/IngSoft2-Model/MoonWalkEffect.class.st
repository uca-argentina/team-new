Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'spacesBackwards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'creation validation' }
MoonWalkEffect class >> checkIsValid: spacesBackwards [
	spacesBackwards > 0
		ifFalse: [ AssertionFailure signal: 'you can not create a moon walk effect with spaces backwards lower than 1' ]
]

{ #category : #'instance creation' }
MoonWalkEffect class >> moving: spacesBackwards [
	self checkIsValid: spacesBackwards.
	^ self new initializeWith: spacesBackwards
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: spacesToGoBackwards [
	spacesBackwards := spacesToGoBackwards
]

{ #category : #'game play' }
MoonWalkEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	(aMatch players copyWithout: aPlayer) do: [ :player | aMatch moveByEffectTo: player spaces: spacesBackwards negated ]
]
