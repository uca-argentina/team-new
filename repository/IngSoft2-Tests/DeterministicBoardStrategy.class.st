Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialze }
DeterministicBoardStrategy >> generateEffectsWith: effectSuccession andBoardOf: anAmountOfSpaces [
	| typeOfEffects |
	typeOfEffects := Array new: anAmountOfSpaces.
	(1 to: anAmountOfSpaces - 1)
		do:
			[ :space | typeOfEffects at: space put: (effectSuccession at: space % effectSuccession size + 1) ].
	typeOfEffects at: anAmountOfSpaces put: NoEffect new.
	^ typeOfEffects
]
