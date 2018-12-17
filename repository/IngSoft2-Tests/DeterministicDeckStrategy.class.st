Class {
	#name : #DeterministicDeckStrategy,
	#superclass : #Object,
	#instVars : [
		'deterministicStrategy'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicDeckStrategy class >> using: aSequence [
	^ self new initializeUsing: aSequence
]

{ #category : #initialization }
DeterministicDeckStrategy >> initializeUsing: aSequence [
deterministicStrategy := DeterministicStrategy using: aSequence
]

{ #category : #generating }
DeterministicDeckStrategy >> nextCard [
	^ deterministicStrategy next
]
