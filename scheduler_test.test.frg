#lang forge
open "scheduler.frg"
option verbose 2

 pred notInPreReqs {
    all s : Semester {
        all c : s.courses | {
            c not in (c.prereqs).Course
            // all req : c.prereqs | some prevS: Semester | reachable[prevS, s, prev] and req in prevS.courses 
        }
    }
 }

  pred notInPrereqs {
    some c : Course {
        #((c.prereqs)) = 0
    }
}
 

pred nonEmptyRegistry {
    all r : Registry {
        #{r.fallRegistry} > 0
        #{r.springRegistry} > 0
    }
}

pred courseinRegistry {
    all c : Course {
        c in Registry.fallRegistry or c in Registry.springRegistry or (c in (Registry.fallRegistry + Registry.springRegistry))
    }
}

pred noDuplicates {
    all disj s1, s2 : Semester {
        all c : Course {
            c not in (s1.courses & s2.courses)
        }
    }
}


// test suite for fulfilledAB {
//     // assert all s: Semester | notInPreReqs is necessary for fulfilledAB for exactly 7 Semester, 6 Int
//     // assert all c: Course | courseinRegistry is necessary for fulfilledAB for exactly 7 Semester, 6 Int
//     //test expect {courseNoPrereq : {some c : Course | {notInPrereqs}} is sat}
//    // assert all c: Course | noDuplicates is necessary for fulfilledAB for exactly 7 Semester, 6 Int
   

// }

// test suite for fulfilledScB {
//     // assert all s: Semester | notInPreReqs is necessary for fulfilledScB for exactly 7 Semester, 6 Int
//     // assert all c: Course | courseinRegistry is necessary for fulfilledScB for exactly 7 Semester, 6 Int
//     //assert all c: Course | noDuplicates is necessary for fulfilledScB for exactly 7 Semester, 6 Int
// }

pred semestersCourseLoadSmall {
    all s : Semester {
        #{s.courses} < 2
    }
 }

 pred semestersCourseLoadLarge {
    all s : Semester {
        #{s.courses} > 6
    }
 }

test suite for traces {
    // test expect {courseLoadInvalidSmall : {some s : Semester | {
    //     semestersCourseLoadSmall
    //     traces
    //     }} for exactly 6 Int is unsat} 

    // test expect {courseLoadInvalidLarge : {some s : Semester | {
    //     semestersCourseLoadLarge
    //     traces
    //     }} for exactly 6 Int is unsat} 

  }

  pred hasPrereqForIntro {
    some s : Semester {
        some r : Registry.intros {
            r in s.courses
            } 
        }
    }
    
    pred bad200 {
        init
        CS0200 in Semester.courses
        (CS0150 not in Semester.courses) and (CS0170 not in Semester.courses) and (CS0112 not in Semester.courses) 

    } 

    pred badMultiplePrereqs {
        init
        CS1410 in Semester.courses
        all prereq : (CS1410.prereqs).Course | {
            some category : prereq.(CS1410.prereqs) | category not in (Semester.^prev).courses
        } 

    } 
    
  
  test suite for introSat {
        // test expect {introInCourse : {some s : Semester | {
        //     hasPrereqForIntro
        //     introSat
        // }} for exactly 7 Semester is sat} 

        // test expect {no200Prereq : {some s : Semester | {
        //     bad200
        //     introSat
        //     semestersRespectPreReqs
        // }} for exactly 7 Semester, 6 Int is unsat} 
  }

  test suite for semestersRespectPreReqs {
    
    // test expect {no200Prereq : {some s : Semester | {
    //     badMultiplePrereqs
    //     semestersRespectPreReqs
    // }} for exactly 7 Semester, 6 Int is unsat} 

  }



//====================================
//====Semesters Linear ===============
//====================================

pred noSemesterIsItsOwnNext {
    all s : Semester {
        s.next != s 
        s.prev != s
    }
}

pred canReachAllOthers[s: Semester] {
    some s.next 
    all otherS: Semester | s != otherS implies { reachable[otherS, s, next] }
}

pred canReachAllOthersBackwards[s: Semester] {
    some s.prev
    all otherS: Semester |s != otherS implies { reachable[otherS, s, prev]}
}
pred oneSemesterIsTheHead {
    #{s : Semester | no s.prev} = 1
    #{s: Semester | canReachAllOthers[s]} = 1
}
pred oneSemesterIsTheTail {
    #{s : Semester | no s.next} = 1
    #{s: Semester | canReachAllOthersBackwards[s]} = 1 
}

pred allSemestersNextIsPrev {
    all s : Semester | some s.next implies s.next.prev = s
}

pred allSemestersPrevIsNext {
    all s : Semester | some s.prev implies s.prev.next = s
}

pred noSemesterIsReachableFromSelf {
    all s : Semester | some s.next implies not reachable[s, s, next] and some s.prev implies not reachable[s, s, prev]
}

pred transposeOfNextIsPrev {
    prev = ~next
}


test suite for semestersLinear {
// - Semesters Linear 
    // - course should not be it's own next
//     assert noSemesterIsItsOwnNext is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - there is only one semester that has no prev
//     assert oneSemesterIsTheHead is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - there is only one semeter that has no next
//     assert oneSemesterIsTheTail is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - for every semester with a next field, the next semester has to have that semester as its prev
//     assert allSemestersNextIsPrev is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - for every semester with a prev field, the prev semester has to have that semester as its next
//     assert allSemestersPrevIsNext is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - no semester should reach itself
//     assert noSemesterIsReachableFromSelf is necessary for semestersLinear for exactly 7 Semester, 6 Int
// //     - next = ~prev (the relation next that points s -> s should be the same as the inverse of prev)
    assert semestersLinear is sufficient for transposeOfNextIsPrev for exactly 7 Semester, 6 Int
}






// /* Test Cases
// - Courses wellformedness
//     - a course should not be it's own pre-req
//     - we should not be able to get an instance where courses with no pre-reqs have pre-reqs
//     - all courses must be one of the sig courses we defined (e.g. all c : Course | c in CS0150 or CS0111 or CS0200 or....)
// - CoursesInCorrectRegistry
//     - all courses should exist in A registry
// - CoursesInCorrectPathways/Level/HaveCorrectPrereqs
//     - idk how you test this... all we're doing is hardcoding the set 
// - Semesters Linear 
//     - course should not be it's own next
//     - there is only one semester that has no prev
//     - there is only one semeter that has no next
//     - for every semester with a next field, the next semester has to have that semester as its prev
//     - for every semester with a prev field, the prev semester has to have that semester as its next
//     - no semester should reach itself
//     - next = ~prev (the relation next that points s -> s should be the same as the inverse of prev)
// - Semester Course Load Valid
//     - sizes 0, 1, 2, 5 are unsat
// - Semesters Respect PreReqs
//     - it's impossible to take cs200 without taking any of the prereqs
//     - test a course with multiple prereqs (maybe ML)
// - Semesters Courses One Time
//     - it's impossible for a course to appear more than once in a study plan
    

    
// pred timeCheck {
//     all c: Course {
//         c.start >= 0
//     }
// }

// pred cartNotEmpty[cart: Cart]{
//     cart.course1 != none
//     cart.course2 != none
//     cart.course3 != none
// }

// pred startBeforeEnd{
//     all c: Course | {
//         c.start < c.end
//     }
// }

// test suite for validCourse {
//     assert timeCheck is necessary for validCourse
//     test expect { timeCheckInsufficient : {
//         {timeCheck} and 
//         not {validCourse}
//     } is sat
//     }
//     example valid_4_course is {validCourse} for {
//     Course = `APMA + `CSCI + `SOC + `EDUC
//     start = `APMA -> 2 + `CSCI -> 4 + `SOC -> 5 + `EDUC -> 6
//     end = `APMA -> 3 + `CSCI -> 5 + `SOC -> 6 + `EDUC -> 7
//     }
//     example invalid_4_course_negative is not {validCourse} for {
//     Course = `EEPS + `CSCI + `ENG + `ECON
//     start = `EEPS -> -4 + `CSCI -> 4 + `ENG -> -2 + `ECON -> 6
//     end = `EEPS -> 3 + `CSCI -> 5 + `ENG -> 6 + `ECON -> 7
// }
//     example invalid_4_course_end_start is not {validCourse} for {
//     Course = `EDUC + `POBS + `HIST + `LITR
//     start = `EDUC -> 4 + `POBS -> 3 + `HIST -> 2 + `LITR -> 1
//     end = `EDUC -> 3 + `POBS -> 2 + `HIST -> 1 + `LITR -> 0
// }
// }

// pred noCoursesOverlap {
//     all disj c1, c2 : Course | {
//         coursesDontOverlap[c1, c2]
//     }
// }

// pred uniqueCourses[c : Cart] {
//     not(c.course1 = c.course2 or 
//         c.course1 = c.course3 or 
//         c.course1 = c.course4 or
//         c.course2 = c.course3 or 
//         c.course2 = c.course4 or
//         c.course3 = c.course4)
// }
// test suite for validCart {
//     example valid_4_course_cart is {validCart} for {
//     Course = `APMA + `CSCI + `SOC + `EDUC
//     start = `APMA -> 2 + `CSCI -> 4 + `SOC -> 5 + `EDUC -> 6
//     end = `APMA -> 3 + `CSCI -> 5 + `SOC -> 6 + `EDUC -> 7
//     Cart = `cart
//     course1 = `cart -> `APMA
//     course2 = `cart -> `CSCI
//     course3 = `cart -> `SOC
//     course4 = `cart -> `EDUC
//     }

//     example valid_3_course_cart is {validCart} for {
//     Course = `APMA + `CSCI + `SOC + `EDUC
//     start = `APMA -> 2 + `CSCI -> 4 + `SOC -> 5 + `EDUC -> 6
//     end = `APMA -> 3 + `CSCI -> 5 + `SOC -> 6 + `EDUC -> 7
//     Cart = `cart
//     course1 = `cart -> `APMA
//     course2 = `cart -> `CSCI
//     course3 = `cart -> `SOC
//     }

//     example empty_cart is not {validCart} for {
//     Course = `APMA + `CSCI + `SOC + `EDUC
//     start = `APMA -> 2 + `CSCI -> 4 + `SOC -> 5 + `EDUC -> 6
//     end = `APMA -> 3 + `CSCI -> 5 + `SOC -> 6 + `EDUC -> 7
//     Cart = `cart
//     }

//     example empty_cart_and_nothing_else is not {validCart} for {
//         Cart = `cart
//     }

//     //this helped us find an underconstraint (we weren't accounting for courses being valid in the cart)
//     //wait this is also a bad test because, it is possible to have a valid cart with overlapping courses
//     //outside of the cart. We are only interested in the courses in the cart, so this predicate is only helpful
//     //for three course carts. 
//     // assert noCoursesOverlap is necessary for validCart for exactly 1 Cart, 4 Course
//     assert noCoursesOverlap is necessary for validCart for exactly 1 Cart, 3 Course

//     //this ensures that courses with negative values are necessary in order to have a valid cart
//     //this also tests for any overconstraint with values by removing the check for end before start
//     assert timeCheck is necessary for validCart for exactly 1 Cart, 4 Course    
//     assert startBeforeEnd is necessary for validCart for exactly 1 Cart, 4 Course

//     test expect {
//         validCartPossible : {
//             some c : Cart | {validCart}
//         } is sat 
//         invalidCartPossible : {
//             some c: Cart | {validCart}
//         } is sat

//     }
// }
//     assert all c : Cart | cartNotEmpty[c] is necessary for validCart 
//         for exactly 1 Cart, 4 Course
//     assert all c : Cart | cartNotEmpty[c] is necessary for validCart 
//         for exactly 1 Cart, 3 Course
//     assert all c: Cart | uniqueCourses[c] is necessary for validCart
//         for exactly 1 Cart, 5 Course

// test suite for coursesDontOverlap {
//     assert all c1,c2: Course | coursesDiffStart[c1,c2] is necessary for coursesDontOverlap[c1,c2] for exactly 1 Cart
//     assert all c1,c2: Course | coursesDiffEnd[c1,c2] is necessary for coursesDontOverlap[c1,c2] for exactly 1 Cart
//     assert all c1,c2: Course | coursesDontHappenSameTime[c1,c2] is necessary for coursesDontOverlap[c1,c2] for exactly 1 Cart

// // communicative property
//     assert all c1,c2: Course | coursesDiffStart[c1,c2] is necessary for coursesDontOverlap[c2,c1] for exactly 1 Cart
//     assert all c1,c2: Course | coursesDiffEnd[c1,c2] is necessary for coursesDontOverlap[c2,c1] for exactly 1 Cart
//     assert all c1,c2: Course | coursesDontHappenSameTime[c1,c2] is necessary for coursesDontOverlap[c2,c1] for exactly 1 Cart

//     test expect{ validCourseValidCart: { all disj c1,c2: Course | coursesDontOverlap[c1,c2] and validCart} is sat}
//     test expect{ validManyCourseValidCart: { all disj c1,c2: Course | coursesDontOverlap[c1,c2] and validCart} for exactly 1 Cart is sat}
//     test expect{ validManyCourseValidCartsome: { some disj c1,c2: Course | coursesDontOverlap[c1,c2] and validCart} for exactly 1 Cart, 7 Course is sat}
//     test expect{ invalidCourseValidCart: { all disj c1: Course |  validCart and coursesDontOverlap[c1,c1]} is unsat}

//     test expect{ invalidCourseInvalidCart: { all disj c1, c2: Course | coursesDontOverlap[c1,c2] and not validCart} is sat}

//     example valid_course_times is {coursesDontOverlap[`APMA, `CSCI]} for {
//     Course = `APMA + `CSCI 
//     start = `APMA -> 2 + `CSCI -> 4 
//     end = `APMA -> 3 + `CSCI -> 5
// }

//     example invalid_course_times is not {coursesDontOverlap[`APMA, `CSCI]} for {
//     Course = `APMA + `CSCI 
//     start = `APMA -> 2 + `CSCI -> 4 
//     end = `APMA -> 5 + `CSCI -> 5
// }
// }



// pred coursesDontHappenSameTime[c1, c2: Course] {
//     (c1.start >= c2.end or c2.start >= c1.end)
// }

// pred coursesDiffStart[c1, c2: Course] {
//     c1.start != c2.start
// }

// pred coursesDiffEnd[c1, c2: Course] {
//     c1.end != c2.end
// }
