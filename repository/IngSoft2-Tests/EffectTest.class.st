Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testPlayerActivateAtomicBombEffect [
	| matias fabio dices board match players |
	board := Board with: 10 of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					AtomicBombEffect new}
				withBoardOf: 10).
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(4 4 1)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	board.
	match
		playedBy: matias;
		playedBy: fabio;
		playedBy: matias.
	self
		assert: (match positionOf: fabio) currentSpace equals: 0;
		assert: (match positionOf: matias) currentSpace equals: 0
]

{ #category : #tests }
EffectTest >> testPlayerActivateMoonWalkEffect [
	| matias fabio dices board match players |
	board := Board
		with: 10
		of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					MoonWalkEffect moving: 1}
				withBoardOf: 10).
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
		assert: (match positionOf: fabio) currentSpace equals: 2;
		assert: (match positionOf: matias) currentSpace equals: 4
]

{ #category : #tests }
EffectTest >> testPlayerActivateSpeedUpEffect [
	| matias dices board match players |
	board := Board
		with: 10
		of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					SpeedUpEffect new}
				withBoardOf: 10).
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 8
]

{ #category : #tests }
EffectTest >> testPlayerActivateWormHoleEffect [
	| matias dices board match players |
	board := Board
		with: 10
		of:
			(DeterministicBoardStrategy
				with:
					{NoEffect new.
					WormHoleEffect  new}
				withBoardOf: 10).
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWith: 5 throwing: #(5)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 1
]
