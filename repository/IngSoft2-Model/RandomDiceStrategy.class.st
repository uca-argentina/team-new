Class {
	#name : #RandomDiceStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomDiceStrategy >> nextNumberUsing: anAmountOfFaces [
	^ anAmountOfFaces atRandom
]
