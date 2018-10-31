Class {
	#name : #AtomicBombEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
AtomicBombEffect >> resetPositionOf: aPlayer on: aMatch [
	^ aMatch
		moveByEffectTo: aPlayer
		spaces: ((aMatch positionOf: aPlayer) currentSpace - 1) negated
]

{ #category : #'game play' }
AtomicBombEffect >> turnOnEffectAt: aMatch activatedBy: aPlayer [
	aMatch players
		do:
			[ :player | self resetPositionOf: player on: aMatch ]
]
