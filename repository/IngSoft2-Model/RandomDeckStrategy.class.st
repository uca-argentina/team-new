Class {
	#name : #RandomDeckStrategy,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#classInstVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomDeckStrategy >> initialize [
	cards := OrderedCollection new
		add: RedoCard new;
		add: RepeatCard new;
		add: SpeedCard new;
		add: OverloadCard new;
		add: AccelerationCard new;
		add: CancellationCard new;
		yourself
]

{ #category : #generating }
RandomDeckStrategy >> nextCard [
^ cards atRandom
]
