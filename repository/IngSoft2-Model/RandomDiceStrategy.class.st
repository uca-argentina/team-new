Class {
	#name : #RandomDiceStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #generating }
RandomDiceStrategy >> nextNumberUsing: anAmountOfFaces [
	| random |
	random := Random new.
	^ random nextInt: anAmountOfFaces
]
