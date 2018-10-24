Class {
	#name : #EffectTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectTest >> testAdjustNegativePositionCausedByEffect [
	| matias dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			WormHoleEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(2)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self
		assert: (match positionOf: matias) currentSpace equals: 9;
		assert: (match positionOf: matias) currentLap equals: -1
]

{ #category : #tests }
EffectTest >> testAdjustPositionWhenChangingLapCausedBySpeedUpEffect [
	| matias dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			SpeedUpEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(5)) with: (Dice deterministicWithSpaces: 5 throwing: #(3)).
	match := Match
		playedBy: players
		throwing: dices
		during: 3
		on: board.
	match playedBy: matias.
	self
		assert: (match positionOf: matias) currentSpace equals: 3;
		assert: (match positionOf: matias) currentLap equals: 1
]

{ #category : #tests }
EffectTest >> testCreatingMoonWalkEffectWithInvalidSpacesBackwards [
	| moonWalkEffect |
	self
		should: [ moonWalkEffect := MoonWalkEffect moving: -5 ]
		raise: AssertionFailure
		withExceptionDo: [ :exception | self assert: exception messageText equals: 'you can not create a moon walk effect with spaces backwards lower than 1' ]
]

{ #category : #tests }
EffectTest >> testPlayerActivateAtomicBombEffect [
	| matias fabio dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			AtomicBombEffect new}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(3 3 1)).
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
EffectTest >> testPlayerActivatesMoonWalkAndGiveMoreThanOneLap [
	| matias fabio dices board match players |
	board := Board deterministicWithSpaces: 5 andEffectsGeneratedFrom: {(MoonWalkEffect moving: 7)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(1)).
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
EffectTest >> testPlayerActivatesMoonWalkEffect [
	| matias fabio dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			(MoonWalkEffect moving: 1)}.
	matias := Player named: 'Matias'.
	fabio := Player named: 'Fabio'.
	players := OrderedCollection with: matias with: fabio.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(3 3 1)).
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
EffectTest >> testPlayerActivatesSpeedUpEffect [
	| matias dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			SpeedUpEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(2)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 7
]

{ #category : #tests }
EffectTest >> testPlayerActivatesWormHoleEffect [
	| matias dices board match players |
	board := Board
		deterministicWithSpaces: 10
		andEffectsGeneratedFrom:
			{NoEffect new.
			WormHoleEffect new}.
	matias := Player named: 'Matias'.
	players := OrderedCollection with: matias.
	dices := Array with: (Dice deterministicWithSpaces: 5 throwing: #(4)).
	match := Match
		playedBy: players
		throwing: dices
		during: 2
		on: board.
	match playedBy: matias.
	self assert: (match positionOf: matias) currentSpace equals: 1
]
