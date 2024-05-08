#lang forge

open "scheduler.frg"


/* Test Cases
- Courses wellformedness
    - a course should not be it's own pre-req
    - we should not be able to get an instance where courses with no pre-reqs have pre-reqs
    - all courses must be one of the sig courses we defined (e.g. all c : Course | c in CS0150 or CS0111 or CS0200 or....)
- CoursesInCorrectRegistry
    - all courses should exist in A registry
- CoursesInCorrectPathways/Level/HaveCorrectPrereqs
    - idk how you test this... all we're doing is hardcoding the set 
- 

    
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
