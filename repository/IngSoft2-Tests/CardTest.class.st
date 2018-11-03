Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
CardTest >> boardWith10SpacesWithoutEffects [
	^ Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom: {NoEffect new}
]

{ #category : #accessing }
CardTest >> playerNamedJose [
	^ Player named: 'Jose'
]

{ #category : #accessing }
CardTest >> playerNamedJuan [
	^ Player named: 'Juan'
]

{ #category : #tests }
CardTest >> testPlayerPlaysAccelerationCard [
	| juan board dice deck match accelerationCard martin jose speedCard |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	martin := Player named: 'Martin'.
	board := self boardWith10SpacesWithoutEffects.
	accelerationCard := AccelerationCard new.
	speedCard := SpeedCard new.
	deck := Deck
		deterministicWithCardSequence:
			{accelerationCard.
			speedCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {1 . 2 . 3}.
	match := Match
		playedBy:
			{juan.
			jose.
			martin}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: accelerationCard by: juan.
	self assert: (match cardsAtHandOf: juan) equals: {speedCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 3.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 4.
	match playedBy: martin.
	self assert: (match positionOf: martin) currentSpace equals: 5
]

{ #category : #tests }
CardTest >> testPlayerPlaysOverloadCard [
	| juan jose board dice deck match overloadCard |
	juan := self playerNamedJuan.
	jose := self playerNamedJose.
	board := self boardWith10SpacesWithoutEffects.
	overloadCard := OverloadCard new.
	deck := Deck deterministicWithCardSequence: {overloadCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {2 . 6}.
	match := Match
		playedBy:
			{juan.
			jose}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: overloadCard to: jose by: juan.
	self
		assert: (match cardsAtHandOf: juan)
		equals: {overloadCard} asOrderedCollection.
	match playedBy: juan.
	match playedBy: jose.
	self assert: (match positionOf: jose) currentSpace equals: 5
]

{ #category : #tests }
CardTest >> testPlayerPlaysSpeedCard [
	| juan  board dice deck match speedCard |
	juan := self playerNamedJuan.
	board := self boardWith10SpacesWithoutEffects.
	speedCard := SpeedCard new.
	deck := Deck deterministicWithCardSequence: {speedCard}.
	dice := Dice deterministicWithFaces: 6 throwing: {5}.
	match := Match
		playedBy:
			{juan.}
		throwing: {dice}
		during: 3
		on: board
		dealingFrom: deck.
	match play: speedCard  to: juan by: juan.
	self
		assert: (match cardsAtHandOf: juan)
		equals: {speedCard} asOrderedCollection.
	match playedBy: juan.
	self assert: (match positionOf: juan) currentSpace equals: 7
]
