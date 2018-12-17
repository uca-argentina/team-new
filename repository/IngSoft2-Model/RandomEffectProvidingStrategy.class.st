Class {
	#name : #RandomEffectProvidingStrategy,
	#superclass : #Object,
	#instVars : [
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomEffectProvidingStrategy >> generateEffectsDistribution [
	effects := OrderedCollection new.
	effects
		addAll: ((1 to: 2) collect: [ :i | AtomicBombEffect new ]);
		addAll: ((1 to: 10) collect: [ :i | DealCardEffect new ]);
		addAll: ((1 to: 10) collect: [ :i | MoonWalkEffect moving: (10 atRandom) ]);
		addAll: ((1 to: 20) collect: [ :i | SpeedUpEffect new ]);
		addAll: ((1 to: 20) collect: [ :i | WormHoleEffect new ]);
		addAll: ((1 to: 38) collect: [ :i | NoEffect new ])
]

{ #category : #initialization }
RandomEffectProvidingStrategy >> initialize [
	self generateEffectsDistribution
]

{ #category : #generating }
RandomEffectProvidingStrategy >> nextEffect [
	^ effects at: 100 atRandom
]
