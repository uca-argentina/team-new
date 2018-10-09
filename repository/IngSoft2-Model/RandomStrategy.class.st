Class {
	#name : #RandomStrategy,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'game play' }
RandomStrategy >> generateNumberUsing: anAmountOfFaces [
	| random |
	random := Random new.
	^ random nextInt: anAmountOfFaces
]
