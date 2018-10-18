Class {
	#name : #RandomBoardStrategy,
	#superclass : #Object,
	#instVars : [
		'typeOfEffects',
		'random',
		'effects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomBoardStrategy class >> withBoardOf: anAmountOfSpaces [
	^ self new initializeEffectsWith: anAmountOfSpaces 
]

{ #category : #initialize }
RandomBoardStrategy >> chosenEffect [
	^ typeOfEffects at: (random nextInt: 100)
]

{ #category : #descriptions }
RandomBoardStrategy >> effects [
	^ typeOfEffects
]

{ #category : #initialize }
RandomBoardStrategy >> generateEffects [
	effects := OrderedCollection new.
	effects
		addAll: ((1 to: 2) collect: [AtomicBombEffect new ]);
		addAll: ((1 to: 10) collect: [MoonWalkEffect moving: (random nextInt: 10) ]);
		addAll: ((1 to: 10) collect: [SpeedUpEffect new ]);
		addAll: ((1 to: 20) collect: [WormHoleEffect new ]);
		addAll: ((1 to: 48) collect: [NoEffect new ])
]

{ #category : #initialize }
RandomBoardStrategy >> initializeEffectsWith: anAmountOfSpaces [
	random := Random new.
	self generateEffects.
	typeOfEffects := (1 to: anAmountOfSpaces) collect: [self chosenEffect ]
]
