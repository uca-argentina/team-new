Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #accessing }
EffectTest >> deckWithOverloadCard [
	^ Deck deterministicWithCardSequence: { OverloadCard new }
]

{ #category : #tests }
EffectTest >> testCreatingMoonWalkEffectWithInvalidSpacesBackwards [
	| moonWalkEffect |
	self
		should: [ moonWalkEffect := MoonWalkEffect moving: -5 ]
		raise: MatchException
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a moon walk effect with spaces backwards lower than 1' ]
]

{ #category : #tests }
EffectTest >> testPlayerActivateAtomicBombEffect [
	| matias fabio dices board match players deck|
	deck:= self deckWithOverloadCard.
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := OrderedCollection
		with: (Dice deterministicWithFaces: 5 throwing: #(2 2 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 1;
		assert: (match positionOf: fabio) currentLap equals: 0;
		assert: (match positionOf: matias) currentSpace equals: 3;
		assert: (match positionOf: matias) currentLap equals: 0.
	match playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 3;
		assert: (match positionOf: fabio) currentLap equals: 0;
		assert: (match positionOf: matias) currentSpace equals: 3;
		assert: (match positionOf: matias) currentLap equals: 0.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 1;
		assert: (match positionOf: fabio) currentLap equals: 0;
		assert: (match positionOf: matias) currentSpace equals: 1;
		assert: (match positionOf: matias) currentLap equals: 0
]

{ #category : #tests }
EffectTest >> testPlayerActivatesGetCardEffect [
	| matias dices board match players deck overloadCard speedCard redoCard |
	overloadCard := OverloadCard new.
	speedCard := SpeedCard new.
	redoCard := RedoCard new.
	deck := Deck
		deterministicWithCardSequence:
			{overloadCard.
			speedCard.
			redoCard}.
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			DealCardEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := OrderedCollection with: (Dice deterministicWithFaces: 5 throwing: #(5)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	self
		assert: (match cardsOf: matias)
		equals:
			{overloadCard.
			speedCard} asOrderedCollection.
	match playedBy: matias.
	self
		assert: (match cardsOf: matias)
		equals:
			{overloadCard.
			speedCard.
			redoCard} asOrderedCollection
]

{ #category : #tests }
EffectTest >> testPlayerActivatesMoonWalkAndLosesMoreThanOneLap [
	| matias fabio dices board match players deck|
	deck:= self deckWithOverloadCard.
	board := Board
		deterministicWithSpaces: 5
		andEffectsGeneratedFrom: {(MoonWalkEffect moving: 7)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := OrderedCollection
		with: (Dice deterministicWithFaces: 5 throwing: #(1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 4;
		assert: (match positionOf: fabio) currentLap equals: -2
]

{ #category : #tests }
EffectTest >> testPlayerActivatesMoonWalkEffect [
	| matias fabio dices board match players deck|
	deck:= self deckWithOverloadCard.
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			(MoonWalkEffect moving: 1)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := OrderedCollection
		with: (Dice deterministicWithFaces: 5 throwing: #(2 2 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 1;
		assert: (match positionOf: matias) currentSpace equals: 3.
	match playedBy: fabio.
	self
		assert: (match positionOf: fabio) currentSpace equals: 3;
		assert: (match positionOf: matias) currentSpace equals: 3.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 2;
		assert: (match positionOf: matias) currentSpace equals: 4
]

{ #category : #tests }
EffectTest >> testPlayerActivatesSpeedUpEffect [
	| matias dices board match players deck|
	deck:= self deckWithOverloadCard.
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			SpeedUpEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := OrderedCollection
		with: (Dice deterministicWithFaces: 5 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 8
]

{ #category : #tests }
EffectTest >> testPlayerActivatesWormHoleEffect [
	| matias dices board match players deck|
	deck:= self deckWithOverloadCard.
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			WormHoleEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := OrderedCollection
		with: (Dice deterministicWithFaces: 5 throwing: #(5)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board
		dealingFrom: deck.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 2
]
