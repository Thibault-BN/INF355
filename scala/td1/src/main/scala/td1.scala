package fr.enst.plnc2013.td1

object TD1 {

  def isOdd(x: Int):Boolean = 
  	((x % 2) == 1)
  def isEven(x: Int):Boolean =
  	!isOdd(x)

  def myWhile[T](condition: => Boolean, f: => T): Unit = {
  	if (condition) {
  		f
  		myWhile(condition,f)}
  }

  def check(row: Int, column: Int, placed: List[(Int,Int)]): Boolean = {
  	if (placed == Nil)
  		true
  	else
  		false
  } 

  def solveQueens(numberOfQueens: Int, f: List[(Int, Int)] => Unit): Unit = {
  	var list = 1 to numberOfQueens toList

  	for (x <- list; y <- list) yield {(x,y)}
  }
}

case class ExtSeq[T](s: Seq[T]){
	
	def any(f: T => Boolean): Boolean = s.map(f).contains(true)
	def all(f: T => Boolean): Boolean = {
		var res = true
		s.foreach( e => { res = res && f(e)})
		res
	}
}

case object ExtSeq {
	implicit def toExtSeq[T](s: Seq[T]) = new ExtSeq[T](s)
}

class ExtCond(b: => Boolean) {

	import TD1._
	def doWhile[T](f: => T): Unit = myWhile(b,f)
}

object ExtCond {
	implicit def toExtCond(b: => Boolean) = new ExtCond(b)
}

case class Complex(r: Double, i: Double) {
	
	override def toString: String = 
		if (i == 0) r.toString
		else if (r == 0) i.toString + "i"
		else if (i < 0 ) r.toString + i.toString + "i"
		else r.toString + "+" + i.toString + "i"

	def reciprocal: Complex = Complex(r, -i)

	def +(c1: Complex): Complex = Complex(r + c1.r, i + c1.i)
}

case object Complex {
	implicit def toComplex(x: Int): Complex = Complex(x,0)
}

object Main extends App {

  import TD1._

  // Placer ici le code à exécuter

}
