package fr.enst.plnc2013

trait Answers {
	def answer(question: String): String
	def answerNot(question: String): String = 
		"not " ++ answer(question)
}

class Normand extends Answers {
	def answer(question: String) = "Maybe"
}

class Bibliothéquaire extends Answers {
	def answer(question: String) = "Ok"
}