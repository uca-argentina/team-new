Class {
	#name : #RandomDiceStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
RandomDiceStrategy >> generateNumberUsing: anAmountOfFaces [
	| random |
	random := Random new.
	^ random nextInt: anAmountOfFaces
]
