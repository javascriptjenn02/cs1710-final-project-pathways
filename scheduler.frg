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
    next: lone Semester,
    prev: lone Semester
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
    core: set Course, 
    related: set Course,
    intermediate: set Course
}

one sig Data_path, Visual_path, Security_path, AI_path, Design_path, Theory_path extends PathWays {}

//OMITTING CS0020, TA APPRENTICESHIPS, AND LABS, THESE ARE ALL CS COURSES, WITH FALL CLASSES IN THE TOP ROW AND SPRING CLASSES IN THE BOTTOM ROW 
one sig CS0111, CS0112, CS0150, CS0170, CS0190, CS0200, CS0220, CS0320, CS0330, CS1010, CS1250, CS1260, CS1270, CS1290, CS1360, CS1410, CS1430, CS1460, CS1510, CS1570, CS1600, CS1650, CS1680, CS1730, CS1760, CS1805, CS1810, CS1860, CS1870, CS1950N, CS1951X, CS1952X, CS1953A,
  CS0300, CS0500, CS1040, CS1300, CS1310, CS1380, CS1420, CS1440, CS1470, CS1515, CS1550, CS1620, CS1660, CS1670, CS1710, CS1800, CS1820, CS1880, CS1950U, CS1951A, CS1951L, CS1951Z, CS1952B, CS1952Q, CS1952Y, CS1952Z extends Course {}
//probability and statistics
one sig APMA1650, APMA1655 extends Course {}
//lin alg 
one sig MATH0520, MATH0540 extends Course {}
//math 
one sig MATH0100 extends Course {}

pred coursesInCorrectRegistrars {
    Registry.fallRegistry = {CS0111 + CS0112 + CS0150 + CS0170 + CS0190 + CS0200 + CS0220 + CS0320 + CS0330 + CS1010 + CS1250 + CS1260 + CS1270 + CS1290 + CS1360 + CS1410 + CS1430 + CS1460 + CS1510 + CS1570 + CS1600 + CS1650 + CS1680 + CS1730 + CS1760 + CS1805 + CS1810 + CS1860 + CS1870 + CS1950N + CS1951X + CS1952X + CS1953A + APMA1650 + APMA1655 + MATH0100 + MATH0520 + MATH0540}
    Registry.springRegistry = {CS0111 + CS0200 + CS0220 + CS0320 + CS0300 + CS0500 + CS1040 + CS1300 + CS1310 +  CS1380 + CS1420 + CS1430 + CS1440 + CS1470 + CS1515 + CS1550 + CS1620 + CS1660 + CS1670 + CS1710 + CS1800 + CS1820 + CS1880 + CS1950U + CS1951A + CS1951L + CS1951Z + CS1952B + CS1952Q + CS1952X + CS1952Y + CS1952Z + APMA1650 + APMA1655 + MATH0100 + MATH0520 + MATH0540}
}

pred coursesInCorrectLevel {
    Registry.intros = {CS0111 + CS0112 + CS0150 + CS0170 + CS0190}
    // Registry.intermediates = {CS0220 + CS0330 + CS0300 + CS0320 + CS0500}
    // Registry.upperLevels = (Registry.fallRegistry + Registry.springRegistry) - (Registry.intros + Registry.intermediates + CS0200)
    Registry.upperLevels = {CS1010 + CS1250 + CS1260 + CS1270 + CS1290 + CS1360 + CS1410 + CS1430 + CS1460 + CS1510 + CS1570 + CS1600 + CS1650 + CS1680 + CS1730 + CS1760 + CS1805 + CS1810 + CS1860 + CS1870 + CS1950N + CS1951X + CS1952X + CS1953A + CS1040 + CS1300 + CS1310 +  CS1380 + CS1420 + CS1430 + CS1440 + CS1470 + CS1515 + CS1550 + CS1620 + CS1660 + CS1670 + CS1710 + CS1800 + CS1820 + CS1880 + CS1950U + CS1951A + CS1951L + CS1951Z + CS1952B + CS1952Q + CS1952X + CS1952Y + CS1952Z}
}

pred coursesInCorrectPathway {
    Data_path.core = {CS1420 + CS1270 + CS1951A}
    Data_path.related = {CS1550}
    //Pathways.visual = {CS1230}  should we add graphics and 1280
    // Pathways.visual = {CS1250 + CS1280 + CS1290 + CS1300 + CS1430 + CS1470 + CS1950U + CS1950N}
    // Pathways.security = {CS1510 + CS1515 + CS1650 + CS1660 + CS1360 + CS1380 + CS1040 + CS1670 + CS1680 + CS1710 + CS1730 + CS1800 + CS1805 + CS1860 + CS1870 + CS1951L}
    // Pathways.ai = {CS1410 + CS1420 + CS1430 + CS1460 + CS1470 + CS1952Q + CS1440 + CS1550 + CS1951A + CS1951Z}
    // Pathways.design = {CS1230 + CS1300 + CS1370 + CS1360 + CS1600 + CS1951A + CS1952B}
    // Pathways.theory = {CS1510 + CS1550 + CS1570 + CS1760 + CS1951X + CS1440 + CS1810 + CS1710 + CS1952Q}

}

pred coursesHaveCorrectPreReqs {
}


pred init {
    // Place it in the correct semester registrar
    {coursesInCorrectRegistrars} 
    // Place it in the correct level: intro intermediate upperlevel
    {coursesInCorrectLevel}
    // Place it in the correct pathway(s)
    {coursesInCorrectPathway}
    // Give it the correct pre-reqs
    {coursesHaveCorrectPreReqs}
}

pred semestersLinear {
    //defining one head and one tail
    //ideally, this is a property we could test but this is to enforce that we get an instance of next and prev
    #{s: Semester | s.prev = none} = 1
    #{s: Semester | s.next = none} = 1
    all s : Semester {
        some s.next implies {
            s.next != s   
            s.next.prev = s   
            not reachable[s, s, next]      
        } 
        some s.prev implies {
            s.prev != s
            s.prev.next = s
            not reachable[s, s, prev]
        }
    }
    //property to test to verify this is correct: ~next = prev
 }

 pred semestersCourseLoadValid {
    all s : Semester {
        #{s.courses} > 2
        #{s.courses} < 6
    }
 }

 pred semestersRespectPreReqs {
    all s : Semester {
        all c : s.courses | {
            all req : c.prereqs | some prevS: Semester | reachable[prevS, s, prev] and req in prevS.courses 
        }
    }
 }

 pred semestersCoursesOneTime {
    all c : Course | {
        //courses can only be taken 0 or 1 time
        #{courses.c} < 2
    }
    // some {c: Course | some s1, s2 : Semester | s1 != s2 and c in s1.courses and c in s2.courses}
 }

 pred semestersAlternate {
    all s : Semester | {
        s in FallSemester or s in SpringSemester
        not (s in FallSemester and s in SpringSemester)
        s in FallSemester implies {
            some s.next implies s.next in SpringSemester
            some s.prev implies s.prev in SpringSemester
        }
    }
 }

 pred semestersTakeCorrectCourses {
    all s : Semester | {
        s in FallSemester implies s.courses in Registry.fallRegistry else s.courses in Registry.springRegistry
    }
 }
pred traces {
    {init}
    //we have to make the semester linear (think back to familyfact)
    {semestersLinear}
    //sems should have 3-5 courses
    {semestersCourseLoadValid}
    // //prereqs need to be satisfied before having a class
    {semestersRespectPreReqs}
    // //can only take a course once
    {semestersCoursesOneTime}
    //semesters alternate between fall and spring
    {semestersAlternate}
    //Spring semesters can only take Spring courses and fall semester can only take fall courses
    {semestersTakeCorrectCourses}

}

//is this needed since all courses basically require intro course
pred introSat {
    all s : Semester {
        all c : s.courses | {
            some req : c.prereqs | some prevS: Semester | one reg : Registry | reachable[prevS, s, prev] and req in r.intros
        }
    }
}



run traces for exactly 7 Semester
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
