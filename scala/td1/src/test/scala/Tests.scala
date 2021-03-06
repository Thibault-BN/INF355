import org.scalatest.{Spec,FlatSpec}
import org.scalatest.matchers._

import fr.enst.plnc2013.td1.TD1._
import fr.enst.plnc2013.td1.ExtSeq._
import fr.enst.plnc2013.td1.Complex
import fr.enst.plnc2013.td1.Complex._
import fr.enst.plnc2013.td1.ExtCond._

class Tests extends Spec with ShouldMatchers {

  describe("isOdd/isEven") {

    it ("should characterize 1 correctly") {
      isOdd(1) should be (true)
      isEven(1) should be (false)
    }

    it ("should characterize 2 correctly") {
      isOdd(2) should be (false)
      isEven(2) should be (true)
    }

  }

  describe("any") {

    it ("should work with an empty list") {
      Nil.any(_ => true) should be (false)
    }

    it ("should identify an odd number") {
      List(1, 2, 3).any(isOdd) should be (true)
    }

    it ("should not identify even numbers") {
      List(2, 4, 6).any(isOdd) should be (false)
    }

  }

  describe ("all") {

    it ("should work with an empty list") {
      Nil.all(_ => false) should be (true)
    }

    it ("should work with all even numbers") {
      List(2, 4, 6).all(isEven) should be (true)
    }

    it ("should fail with an odd number in the list") {
      List(2, 4, 5, 6).all(isEven) should be (false)
    }

  }

  describe("myWhile") {

    it("should not evaluate actions when false") {
      var c = 0
      myWhile(false, c += 1)
      c should equal (0)
    }

    it("should not evaluate action several times") {
      var c = 0
      myWhile({c += 1; false}, c += 10)
      c should equal (1)
    }

    it("should evaluate actions while true") {
      var c = 0
      var x = 0
      myWhile(x < 4, { c += x; x+= 1 })
      c should equal (6)
    }

  }

  describe("doWhile") {

    it ("should work with an automatic conversion") {
      var x = 0
      var c = 0
      (x < 4) doWhile {
	c += x
	x += 1
      }
      c should equal(6)
    }

  }

  describe("a Complex") {

    it ("should print properly") {
      Complex(0, 0).toString should equal("0.0")
      Complex(0, 1.2).toString should equal("1.2i")
      Complex(1.2, 0).toString should equal("1.2")
      Complex(1.2, 3.4).toString should equal("1.2+3.4i")
      Complex(1.2, -3.4).toString should equal("1.2-3.4i")
      Complex(0, -1.2).toString should equal("-1.2i")
    }

    it ("should have a proper reciprocal") {
      Complex(1.2, 3.4).reciprocal.toString should equal("1.2-3.4i")
    }

    it ("should handle complex addition") {
      Complex(1, 2) + Complex(3, 4) should equal(Complex(4, 6))
    }

    it ("should handle addition with an integer") {
      Complex(1, 2) + 3 should equal(Complex(4, 2))
      3 + Complex(1, 2) should equal(Complex(4, 2))
    }

  }

//   describe("solveQueens") {
//
//     it ("should find the unique solution for 1 queen") {
//       var l = List[(Int, Int)]()
//       solveQueens(1, l :::= _)
//       l should equal (List((1, 1)))
//     }
//
//     it ("should not find any solution for 2 and 3 queens") {
//       var n = 0
//       solveQueens(2, _ => n += 1)
//       solveQueens(3, _ => n += 1)
//       n should equal (0)
//     }
//
//     it ("should find all solutions for 8 queens") {
//       var n = 0
//       solveQueens(8, _ => n += 1)
//       n should equal (92)
//     }
//
//   }

}
