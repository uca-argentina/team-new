Class {
	#name : #DeterministicStrategy,
	#superclass : #Object,
	#instVars : [
		'sequence',
		'index'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicStrategy class >> using: aSequence [
	^ self new initializeUsing: aSequence
]

{ #category : #initialization }
DeterministicStrategy >> initializeUsing: aSequence [
	sequence := aSequence.
	index := 0
]
