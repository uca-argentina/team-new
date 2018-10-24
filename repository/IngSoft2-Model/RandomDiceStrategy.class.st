Class {
	#name : #RandomDiceStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomDiceStrategy >> generateNumberUsing: anAmountOfFaces [
	| random |
	random := Random new.
	^ random nextInt: anAmountOfFaces
]
