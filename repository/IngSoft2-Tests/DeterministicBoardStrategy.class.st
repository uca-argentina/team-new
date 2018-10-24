Class {
	#name : #DeterministicBoardStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Tests'
}

{ #category : #initialze }
DeterministicBoardStrategy >> generateEffectsWith: anEffectSuccession andBoardOf: anAmountOfSpaces [
	| typeOfEffects |
	typeOfEffects := OrderedCollection new.
	typeOfEffects
		addAll: ((1 to: anAmountOfSpaces - 1) collect: [ :space | anEffectSuccession at: space % anEffectSuccession size + 1 ]);
		add: NoEffect new.
	^ typeOfEffects
]
