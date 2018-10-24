Class {
	#name : #MoonWalkEffect,
	#superclass : #Effect,
	#instVars : [
		'spacesBackwards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalkEffect class >> moving: spacesBackwards [
	^ self new initializeWith: spacesBackwards
]

{ #category : #initialization }
MoonWalkEffect >> initializeWith: spacesToGoBackwards [
	spacesBackwards := spacesToGoBackwards
]

{ #category : #'game play' }
MoonWalkEffect >> turnOnEffectAt: aGame activatedBy: aPlayer [
	(aGame players copyWithout: aPlayer) do: [ :player | aGame moveByEffectTo: player spaces: spacesBackwards negated ]
]
