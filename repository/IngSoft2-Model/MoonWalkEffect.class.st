Class {
	#name : #MoonWalkEffect,
	#superclass : #Object,
	#instVars : [
		'spacesBackwards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> moving: spacesToGoBackwards [
	^ self new initializeWith: spacesToGoBackwards
]

{ #category : #initialize }
MoonWalkEffect >> initializeWith: spacesToGoBackwards [
	spacesBackwards := spacesToGoBackwards
]

{ #category : #'game play' }
MoonWalkEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	(aGame players copyWithout: aPlayer)
		do: [ :player | aGame moveByEffectTo: player spaces: spacesBackwards negated]
]
