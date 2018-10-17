Class {
	#name : #RandomBoardStrategy,
	#superclass : #Object,
	#instVars : [
		'typeOfEffects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
RandomBoardStrategy >> chosenEffect [
	| random |
	random := Random new.
	^ typeOfEffects  at: (random nextInt: 100)
]

{ #category : #initialize }
RandomBoardStrategy >> generateEffects [
	typeOfEffects := Array new: 100.
	1 to: 2 do: [ :i | typeOfEffects at: i put: AtomicBombEffect new ].
	3 to: 12 do: [ :i | typeOfEffects at: i put: (MoonWalkEffect moving: ((Random new) nextInt: 10)) ].
	13 to: 32 do: [ :i | typeOfEffects at: i put: SpeedUpEffect new ].
	33 to: 52 do: [ :i | typeOfEffects at: i put: WormHoleEffect new ].
	53 to: 100 do: [ :i | typeOfEffects at: i put: NoEffect new ]
]

{ #category : #initialize }
RandomBoardStrategy >> initializeEffectsWith: anAmountOfSpaces [
	| effects |
	self generateEffects.
	effects := Array new: anAmountOfSpaces.
	^(1 to: anAmountOfSpaces do: [ :aSpace | effects at: aSpace put: self chosenEffect ])
]
