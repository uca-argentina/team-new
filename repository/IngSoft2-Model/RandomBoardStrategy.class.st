Class {
	#name : #RandomBoardStrategy,
	#superclass : #Object,
	#instVars : [
		'random',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomBoardStrategy >> chosenEffect [
	^ effects at: (random nextInt: 100)
]

{ #category : #generating }
RandomBoardStrategy >> generateEffectsDistribution [
	effects := OrderedCollection new.
	effects
		addAll: ((1 to: 2) collect: [ :i | AtomicBombEffect new ]);
		addAll: ((1 to: 10) collect: [ :i | MoonWalkEffect moving: (random nextInt: 10) ]);
		addAll: ((1 to: 20) collect: [ :i | SpeedUpEffect new ]);
		addAll: ((1 to: 20) collect: [ :i | WormHoleEffect new ]);
		addAll: ((1 to: 48) collect: [ :i | NoEffect new ])
]

{ #category : #generating }
RandomBoardStrategy >> generateEffectsWith: anEffectSuccession andBoardOf: anAmountOfSpaces [
	^ (1 to: anAmountOfSpaces) collect: [ :space | self chosenEffect ]
]

{ #category : #initialization }
RandomBoardStrategy >> initialize [
	random := Random new.
	self generateEffectsDistribution
]
