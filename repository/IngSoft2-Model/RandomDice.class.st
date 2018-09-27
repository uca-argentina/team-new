Class {
	#name : #RandomDice,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #rolling }
RandomDice >> roll: anAmountOfFaces [
	| random |
	random := Random new.
	^ random nextInt: anAmountOfFaces
]
