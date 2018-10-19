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
	(aGame playersPositions reject: [ :playerWithPosition | playerWithPosition key = aPlayer ])
		do: [ :playerPosition | 
			playerPosition
				value:
					((Position
						on: (aGame positionOf: playerPosition key) value currentSpace - spacesBackwards
						at: (aGame positionOf: playerPosition key) value currentLap) adjustGoingBackwardsWith: aGame board) ]
]
