Class {
	#name : #RepeatCard,
	#superclass : #InstantCard,
	#category : #'IngSoft2-Model'
}

{ #category : #applying }
RepeatCard >> applyIn: aMatch to: aPlayer [
	aMatch lastEffect turnOnEffectAt: aMatch activatedBy: aMatch lastEffectTarget.
	aMatch updateLastCard: self
]

{ #category : #applying }
RepeatCard >> redoIn: aMatch to: aPlayer by: aRedoCard [ 
	aMatch lastEffect turnOnEffectAt: aMatch activatedBy: aMatch lastEffectTarget.
	aMatch updateLastCard: aRedoCard
]
