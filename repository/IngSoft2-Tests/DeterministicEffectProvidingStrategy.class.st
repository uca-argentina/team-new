Class {
	#name : #DeterministicEffectProvidingStrategy,
	#superclass : #Object,
	#instVars : [
		'deterministicStrategy'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
DeterministicEffectProvidingStrategy class >> using: aSequence [
	^ self new initializeUsing: aSequence
]

{ #category : #initialization }
DeterministicEffectProvidingStrategy >> initializeUsing: aSequence [
deterministicStrategy := DeterministicStrategy using: aSequence

]

{ #category : #generating }
DeterministicEffectProvidingStrategy >> nextEffect [
	^ deterministicStrategy  next
]
