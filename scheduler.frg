#lang forge

/**
this is the courses sig, it represents a single course with a set of prereqs
**/
sig Course {
    // start: one Int,
    // end: one Int, 
    prereqs: set Course
}

/*
* This is the Cart sig, it has four fields for 4 different courses. One of the fields is lone, 
* meaning that 3 course carts are possible
*/
abstract sig Semester {
    // course1: one Course,
    // course2: one Course,
    // course3: one Course,
    // course4: lone Course
    courses: set Course,
    next: lone Semester
}

sig FallSemester extends Semester {}
sig SpringSemester extends Semester {}

one sig Registry {
    fallRegistry: set Course, 
    springRegistry: set Course, 
    intros: set Course, 
    intermediates: set Course, 
    upperLevels: set Course
}

one sig PathWays {
    data: set Course, 
    visual: set Course, 
    security: set Course, 
    ai: set Course, 
    design: set Course, 
    theory: set Course
}

//OMITTING CS0020, TA APPRENTICESHIPS, AND LABS, THESE ARE ALL CS COURSES, WITH FALL CLASSES IN THE TOP ROW AND SPRING CLASSES IN THE BOTTOM ROW 
sig CS0111, CS0112, CS0150, CS0170, CS0190, CS0200, CS0220, CS0320, CS0330, CS1010, CS1250, CS1260, CS1270, CS1290, CS1360, CS1410, CS1430, CS1460, CS1510, CS1570, CS1600, CS1650, CS1680, CS1730, CS1760, CS1805, CS1810, CS1860, CS1870, CS1950N, CS1951X, CS1952X, CS1953A,
  CS0300, CS0500, CS1040, CS1300, CS1310, CS1380, CS1420, CS1440, CS1470, CS1515, CS1550, CS1620, CS1660, CS1670, CS1710, CS1800, CS1880, CS1950U, CS1951A, CS1951L, CS1951Z, CS1952B, CS1952Q, CS1952Y, CS1952Z extends Course {}

pred coursesInCorrectRegistrars {
    CS0111 in Registry.springRegistry and 
    CS0111 in Registry.fallRegistry and 
    {CS0111 + CS0150 + CS0170} = Registry.fallRegistry
}

pred coursesInCorrectLevel {

}

pred coursesInCorrectPathway {

}

pred coursesHaveCorrectPreReqs {

}


pred init {
    // Place it in the correct semester registrar
    coursesInCorrectRegistrars 
    // Place it in the correct level: intro intermediate upperlevel
    coursesInCorrectLevel
    // Place it in the correct pathway(s)
    coursesInCorrectPathway
    // Give it the correct pre-reqs
    coursesHaveCorrectPreReqs
}

run init for exactly 7 Semester
/**
*This predicate ensues that two courses don't overlap.
**/
// pred coursesDontOverlap[c1, c2: Course] {
//     c1.start != c2.start
//     c1.end != c2.end
//     //rather than writing what is not allowed, we can express this predicate in a way that only 
//     //allows what is allowed. 
//     (c1.start >= c2.end or c2.start >= c1.end)
// }

// /**
// * This predicate ensures that all courses are wellformed. An alternate approach would be a preidcate that
// * takes in a single course and validates it as wellformed. 
// */
// pred validCourse {
//     all c: Course {
//         c.start < c.end 
//         c.start >= 0
//     }
// }

// /**
// * This is the predicate that forms what a valid cart is. It checks that courses are valid and that 
// * all of its courses do not overlap with each other. 
// */
// pred validCart {
//  {validCourse}
//  all c: Cart {
//     some disj c1, c2, c3 : Course {
//         c.course1 = c1
//         c.course2 = c2
//         c.course3 = c3
//         coursesDontOverlap[c1, c2]
//         coursesDontOverlap[c1, c3]
//         coursesDontOverlap[c2, c3]
//         some c.course4 implies {
//             c.course4 != c.course1
//             c.course4 != c.course2
//             c.course4 != c.course3
//             coursesDontOverlap[c1, c.course4]
//             coursesDontOverlap[c2, c.course4]
//             coursesDontOverlap[c3, c.course4]
//         }
//     }
//  }
// }

// /**
// * this predicate was used to explore our model. We weren't getting 4 course Carts at first so we forced 
// * an instance by including this in the run statement. 
// */
// pred fourCourses {
//     all c: Cart {
//         some c.course1
//         some c.course2
//         some c.course3
//         some c.course4
//     }
// }
// //this gives us a valid cart. 
// run { validCart } for 1 Cart, exactly 4 Course
