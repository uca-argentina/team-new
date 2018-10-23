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
	(aGame players reject: [ :player | player=aPlayer ])
		do: [ :player | 
			aGame playersPositions
				at: player
				put:
					((Position on: (aGame positionOf: player) currentSpace - spacesBackwards at: (aGame positionOf: player) currentLap)
						adjustGoingBackwardsWith: aGame board) ]
]
