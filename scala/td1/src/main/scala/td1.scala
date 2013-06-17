package fr.enst.plnc2013.td1

object TD1 {

  def isOdd(x: Int):Boolean = 
  	((x % 2) == 1)
  def isEven(x: Int):Boolean =
  	!isOdd(x)

}

object Main extends App {

  import TD1._

  // Placer ici le code à exécuter

}
