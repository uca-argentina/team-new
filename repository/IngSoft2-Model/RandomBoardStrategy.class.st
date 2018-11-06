Class {
	#name : #RandomBoardStrategy,
	#superclass : #Object,
	#instVars : [
		'effects',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomBoardStrategy >> generateEffectsDistribution [
	effects := OrderedCollection new.
	effects
		addAll: ((1 to: 2) collect: [ :i | AtomicBombEffect new ]);
		addAll: ((1 to: 10) collect: [ :i | DealCardEffect new ]);
		addAll: ((1 to: 10) collect: [ :i | MoonWalkEffect moving: (random nextInt: 10) ]);
		addAll: ((1 to: 20) collect: [ :i | SpeedUpEffect new ]);
		addAll: ((1 to: 20) collect: [ :i | WormHoleEffect new ]);
		addAll: ((1 to: 38) collect: [ :i | NoEffect new ])
]

{ #category : #initialization }
RandomBoardStrategy >> initialize [
	random := Random new.
	self generateEffectsDistribution
]

{ #category : #generating }
RandomBoardStrategy >> nextEffect [
	^ effects at: (random nextInt: 100)
]
