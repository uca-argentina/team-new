Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #generating }
DeterministicBoardStrategy >> generateEffectsWith: anEffectSuccession andBoardOf: anAmountOfSpaces [
	| typeOfEffects |
	typeOfEffects := OrderedCollection new.
	typeOfEffects
		addAll: ((1 to: anAmountOfSpaces) collect: [ :space | anEffectSuccession at: space % anEffectSuccession size + 1 ]).
	^ typeOfEffects
]
