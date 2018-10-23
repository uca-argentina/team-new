Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialze }
DeterministicBoardStrategy >> generateEffectsWith: effectSuccession andBoardOf: anAmountOfSpaces [
	| typeOfEffects |
	typeOfEffects := OrderedCollection new.
	typeOfEffects
		addAll: ((1 to: anAmountOfSpaces - 1) collect: [ :space | effectSuccession at: space % effectSuccession size + 1 ]).
	typeOfEffects add: NoEffect new.
	^ typeOfEffects
]
