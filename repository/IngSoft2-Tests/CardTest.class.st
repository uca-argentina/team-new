Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testPlayerPlaysOverloadCard [
	| juan jose board dice deck match overloadCard |
	juan := Player named: 'Juan'.
	jose := Player named: 'Jose'.
	board := Board deterministicWithSpaces: 10 andEffectsGeneratedFrom: {NoEffect new}.
	overloadCard := OverloadCard new.
	deck := Deck deterministicWithCardSequence: {overloadCard}.
	dice := Dice deterministicWithSpaces: 6 throwing: {2 . 6}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: overloadCard to: jose by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {overloadCard} asOrderedCollection.
	match playedBy: juan.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5
]
