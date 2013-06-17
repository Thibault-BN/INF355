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

object Main extends App {

  import TD1._

  // Placer ici le code à exécuter

}
