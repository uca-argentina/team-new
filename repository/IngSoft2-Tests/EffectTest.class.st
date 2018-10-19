Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAdjustNegativePositionOfAPlayer [
	| matias dices board match players |
	board := Board
		deterministicWith: 10
		with:
			{NoEffect new.
			WormHoleEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(2)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match.
	match playedBy: matias.
	self
		assert: (match positionOf: matias) currentSpace equals: 9;
		assert: (match positionOf: matias) currentLap equals: -1
]

{ #category : #tests }
EffectTest >> testPlayerActivateAtomicBombEffect [
	| matias fabio dices board match players |
	board := Board
		deterministicWith: 10
		with:
			{NoEffect new.
			AtomicBombEffect new}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(3 3 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match
		playedBy: matias;
		playedBy: fabio;
		playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 1;
		assert: (match positionOf: matias) currentSpace equals: 1
]

{ #category : #tests }
EffectTest >> testPlayerActivateMoonWalkAndGiveMoreThanOneLap [
	| matias fabio dices board match players |
	board := Board deterministicWith: 5 with: {(MoonWalkEffect moving: 7)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 4;
		assert: (match positionOf: fabio) currentLap equals: -2
]

{ #category : #tests }
EffectTest >> testPlayerActivateMoonWalkEffect [
	| matias fabio dices board match players |
	board := Board
		deterministicWith: 10
		with:
			{NoEffect new.
			(MoonWalkEffect moving: 1)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(3 3 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match
		playedBy: matias;
		playedBy: fabio;
		playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 3;
		assert: (match positionOf: matias) currentSpace equals: 5
]

{ #category : #tests }
EffectTest >> testPlayerActivateSpeedUpEffect [
	| matias dices board match players |
	board := Board
		deterministicWith: 10
		with:
			{NoEffect new.
			SpeedUpEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(2)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 7
]

{ #category : #tests }
EffectTest >> testPlayerActivateWormHoleEffect [
	| matias dices board match players |
	board := Board
		deterministicWith: 10
		with:
			{NoEffect new.
			WormHoleEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(4)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 1
]
