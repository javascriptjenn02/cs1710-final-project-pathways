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
    upperLevels: set Course,
    foundationsInter: set Course, 
    mathInter: set Course, 
    systemsInter: set Course
}


abstract sig PathWays {
    core: set Course, 
    related: set Course,
    intermediate: set Course
}

one sig Data_path, Visual_path, Security_path, AI_path, Design_path, Theory_path extends PathWays {}

//OMITTING CS0020, TA APPRENTICESHIPS, AND LABS, THESE ARE ALL CS COURSES, WITH FALL CLASSES IN THE TOP ROW AND SPRING CLASSES IN THE BOTTOM ROW 
one sig CS0111, CS0112, CS0150, CS0170, CS0190, CS0200, CS0220, CS0320, CS0330, CS1010, CS1230, CS1250, CS1260, CS1270, CS1280, CS1290, CS1360, CS1410, CS1430, CS1460, CS1510, CS1570, CS1600, CS1650, CS1680, CS1730, CS1760, CS1805, CS1810, CS1860, CS1870, CS1950N, CS1951X, CS1952X, CS1953A,
  CS0300, CS0500, CS1040, CS1300, CS1310, CS1380, CS1420, CS1440, CS1470, CS1515, CS1550, CS1620, CS1660, CS1670, CS1710, CS1800, CS1820, CS1880, CS1950U, CS1951A, CS1951L, CS1951Z, CS1952B, CS1952Q, CS1952Y, CS1952Z, 
  APMA1650, APMA1655, 
  MATH0520, MATH0540, 
  MATH0100 extends Course {}

pred coursesInCorrectRegistrars {
    Registry.fallRegistry = {CS0111 + CS0112 + CS0150 + CS0170 + CS0190 + CS0200 + CS0220 + CS0320 + CS0330 + CS1010 + CS1250 + CS1260 + CS1270 + CS1280 + CS1290 + CS1360 + CS1410 + CS1430 + CS1460 + CS1510 + CS1570 + CS1600 + CS1650 + CS1680 + CS1730 + CS1760 + CS1805 + CS1810 + CS1860 + CS1870 + CS1950N + CS1951X + CS1952X + CS1953A + APMA1650 + APMA1655 + MATH0100 + MATH0520 + MATH0540}
    Registry.springRegistry = {CS0111 + CS0200 + CS0220 + CS0320 + CS0300 + CS0500 + CS1040 + CS1300 + CS1310 +  CS1380 + CS1420 + CS1430 + CS1440 + CS1470 + CS1515 + CS1550 + CS1620 + CS1660 + CS1670 + CS1710 + CS1800 + CS1820 + CS1880 + CS1950U + CS1951A + CS1951L + CS1951Z + CS1952B + CS1952Q + CS1952X + CS1952Y + CS1952Z + APMA1650 + APMA1655 + MATH0100 + MATH0520 + MATH0540}
}

pred coursesInCorrectLevel {
    Registry.intros = {CS0111 + CS0112 + CS0150 + CS0170 + CS0190}
    Registry.foundationsInter = {CS0220 + CS1010}
    Registry.systemsInter = {CS0320 + CS0330 + CS0300}
    Registry.mathInter = {MATH0520 + MATH0540}
    Registry.upperLevels = {CS1010 + CS1230 + CS1250 + CS1260 + CS1270 + CS1290 + CS1360 + CS1410 + CS1430 + CS1460 + CS1510 + CS1570 + CS1600 + CS1650 + CS1680 + CS1730 + CS1760 + CS1805 + CS1810 + CS1860 + CS1870 + CS1950N + CS1951X + CS1952X + CS1953A + CS1040 + CS1300 + CS1310 +  CS1380 + CS1420 + CS1430 + CS1440 + CS1470 + CS1515 + CS1550 + CS1620 + CS1660 + CS1670 + CS1710 + CS1800 + CS1820 + CS1880 + CS1950U + CS1951A + CS1951L + CS1951Z + CS1952B + CS1952Q + CS1952X + CS1952Y + CS1952Z}
}

pred coursesInCorrectPathway {
    Data_path.core = {CS1420 + CS1270 + CS1951A}
    Data_path.related = {CS1550}
    Data_path.intermediate = {APMA1650 + APMA1655 + CS0320 + CS0300 + CS0330 + MATH0520 + MATH0540}

    Visual_path.core = {CS1230 + CS1250 + CS1280 + CS1290 + CS1300 + CS1430}
    //Pathways.visual = {CS1230}  should we add graphics and 1280
    Visual_path.related = {CS1470 + CS1950U + CS1950N}
    Visual_path.intermediate = {CS0300 + CS0320 + CS0330}

    Security_path.core = {CS1510 + CS1515 + CS1650 + CS1660}
    Security_path.related = {CS1360 + CS1380 + CS1040 + CS1670 + CS1680 + CS1710 + CS1730 + CS1800 + CS1805 + CS1860 + CS1870 + CS1951L}
    Security_path.intermediate = {CS0220 + APMA1650 + APMA1655 + CS0300 + CS0330}

    AI_path.core = {CS1410 + CS1420 + CS1430 + CS1460 + CS1470 + CS1952Q}
    AI_path.related = {CS1440 + CS1550 + CS1951A + CS1951Z}
    AI_path.intermediate = {APMA1650 + APMA1655 + MATH0520 + MATH0540}

    Design_path.core = {CS1230 + CS1300}
    Design_path.related = {CS1360 + CS1600 + CS1951A + CS1952B}
    Design_path.intermediate = {CS0320 + CS0300 + CS0330 + APMA1650 + APMA1655}

    Theory_path.core = {CS1510 + CS1550 + CS1570 + CS1760 + CS1951X}
    Theory_path.related = {CS1440 + CS1810 + CS1710 + CS1952Q}
    Theory_path.intermediate = {APMA1650 + APMA1655 + CS1010 + MATH0520 + MATH0540}

}

pred coursesHaveCorrectPreReqs {
}


pred init {
    // Place it in the correct semester registrar
    {coursesInCorrectRegistrars} 
    // Place it in the correct level: intro intermediate upperlevel
    {coursesInCorrectLevel}
    // // Place it in the correct pathway(s)
     {coursesInCorrectPathway}
    // // Give it the correct pre-reqs
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
        s in SpringSemester implies {
            some s.next implies s.next in FallSemester
            some s.prev implies s.prev in FallSemester
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
    //prereqs need to be satisfied before having a class
    {semestersRespectPreReqs}
    //can only take a course once
    {semestersCoursesOneTime}
    //semesters alternate between fall and spring
    {semestersAlternate}
    //Spring semesters can only take Spring courses and fall semester can only take fall courses
    {semestersTakeCorrectCourses}
}

//is this needed since all courses basically require intro course
//intro seq set should be cs19 and cs200 since pre-reqs require 15, 17, etc. 
pred introSat {
    CS0200 in Semester.courses or CS0190 in Semester.courses
}


pred pathwayCompletedAB[p : PathWays] {
    //there is one foundations intermediate
    //there is one math intermediate
    //there is one systems intermediate
    #{c : Course | c in Semester.courses and c in Registry.foundationsInter} >= 1
    #{c : Course | c in Semester.courses and c in Registry.mathInter}>= 1
    #{c : Course | c in Semester.courses and c in Registry.systemsInter} >= 1
    //Note from Juan: i think this doesnt constrain that minimum one needs to come from core
    #{c : Course | (c in Semester.courses) and (c in p.core)} >= 2 or (#{c : Course | (c in Semester.courses) and (c in p.core + p.related)} >= 2)
    #{c : Course | (c in Semester.courses) and (c in (Registry.upperLevels - (p.core + p.related)))} >= 1

    //say that there's some pathway P |
        //the union of p.core and courses is > 0
        //{the union of p.core and Semester.courses + the union of p.related and Semester.courses} >= 2
        //and 
        //there is some course extraUL | extraUL is in Semester.courses, not in p.core, not in p.related, and in upperLevels
    }

pred onePathwayDoneAB {
    one p: PathWays {
        pathwayCompletedAB[p]
    } 

    //Proposed by Juan: if this is faster we can do this
    // some p : PathWays | pathwayCompletedAB[p]

    //We can use this constraint if we want to underconstrain (allow multiple pathways to be completed):
    // pathwayCompletedAB[Data_path] or pathwayCompletedAB[Visual_path] or pathwayCompletedAB[Security_path] 
    // or pathwayCompletedAB[AI_path] or pathwayCompletedAB[Design_path] or pathwayCompletedAB[Theory_path]
    //Response from Juan: this would be the same as using some instead of one as the quantifier for pathways 
}

pred fulfilledAB {
    traces
    introSat
    onePathwayDoneAB
}

pred pathwayCompletedScB[p: PathWays] {
    //there is one foundations intermediate
    //there is one math intermediate
    //there is one systems intermediate
    #{c : Course | c in Semester.courses and c in Registry.foundationsInter} >= 1
    //The probability courses are missing, maybe take out the honors courses (540 and 1655) because you can only take one
    #{c : Course | c in Semester.courses and c in Registry.mathInter} = 1
    //ACTUALLY only one systems course can be counted towards concentration so change this to one perhaps
    #{c : Course | c in Semester.courses and c in Registry.systemsInter} >= 1
    #{c : Course | (c in (Semester.courses & (Registry.foundationsInter +  Registry.mathInter + Registry.systemsInter))) } >= 5

    #{c : Course | (c in Semester.courses) and (c in p.core)} >= 2 or (#{c : Course | (c in Semester.courses) and (c in p.core + p.related)} >= 2)
   // #{c : Course | (c in Semester.courses) and (c in (Registry.upperLevels - (p.core + p.related)))} = 1
    //#{c : Course | (c in Semester.courses) and (c in Registry.upperLevels - (Semester.courses & p.core & p.related))} >= 3
    //AHHHH AM I OVER CONSTRAINING?? elective courses can be in pathway as long as there is at least one upperlevel course that is unrelated 
    #{c : Course | (c in Registry.upperLevels) and (c in (Semester.courses - (p.core + p.related)))} >=3


    //say that there's some pathway P |
        //the union of p.core and courses is > 0
        //{the union of p.core and Semester.courses + the union of p.related and Semester.courses} >= 2
        //and 
        //there is some course extraUL | extraUL is in Semester.courses, not in p.core, not in p.related, and in upperLevels
    }

pred twoPathwaysDoneScB{
    one p1, p2, p3, p4, p5, p6 : PathWays {
        pathwayCompletedScB[p1] and pathwayCompletedScB[p2]
        (!pathwayCompletedScB[p3] and !pathwayCompletedScB[p4] and !pathwayCompletedScB[p5] and !pathwayCompletedScB[p6])
    } 

    //Proposed by Juan: (idk if this is faster but try running this and if it is we can keep it)
    // some p1, p2 : PathWays | p1 != p2 and pathwayCompletedSCB[p1] and pathwayCompletedSCB[p2]
}
pred fulfilledScB {
    traces
    introSat
    twoPathwaysDoneScB
}


// run {fulfilledAB} for exactly 7 Semester
// run {fulfilledScB fulfilledAB} for exactly 7 Semester

pred satisfiesNewMathFoundation[c: Course] {
    c in (CS0220 + APMA1650) // +   CS1450
}

pred satisfiesNewAlgoFoundation[c: Course]{
    c in (CS0500 + CS1010 + CS1550 + CS1570)
}

pred satisfiesNewAIMLFoundation[c: Course] {
    c in (CS1410 + CS1420 + CS1430 + CS1460 + CS1470 + CS1951A)
}

pred fulfilledABNew {
    //give a valid trace
    traces 
    //satisfy the intro sequence
    introSat

    some disj math, alg, ai, sys, uppL1, uppL2, el1, el2 : Course | {
        //satisfy the math foundations
        satisfiesNewMathFoundation[math]
        //satisfy the algorithms/theory req 
        satisfiesNewAlgoFoundation[alg]
        //satisfy the AI/ML req
        satisfiesNewAIMLFoundation[ai]
        //satisfy the systems foundations 
        sys in (CS0300 + CS0320 + CS0330)
        //take two upper level courses not equal to the foundations courses
        // uppL1 != uppL2 and uppL1 != math and uppL1 != alg and uppL1 != ai and uppL1 != sys
        uppL1 in Registry.upperLevels
        // uppL2 != math and uppL2 != alg and uppL2 != ai and uppL2 != sys 
        uppL2 in Registry.upperLevels
        //take two new electives 
        el1 + el2 in (CS0320 + Registry.upperLevels + MATH0520)
        //need to fulfill a capstone
        //....
        //....

        (math + alg + ai + sys + uppL1 + uppL2 + el1 + el2) in Semester.courses
    }
}

// run fulfilledABNew for exactly 7 Semester

pred fulfilledSCBNew {
    //need a valid trace
    traces
    //need to satisfy the intro sequence
    introSat
    //need to take math 100
    MATH0100 in Semester.courses
    some disj math, alg, ai, sys, uppL1, uppL2, uppL3, uppL4, uppL5, el1, el2, el3, el4: Course | {
        //satisfy the math foundations
        satisfiesNewMathFoundation[math]
        //satisfy the algorithms/theory req 
        satisfiesNewAlgoFoundation[alg]
        //satisfy the AI/ML req
        satisfiesNewAIMLFoundation[ai]
        //satisfy the systems foundations 
        sys in (CS0300 + CS0320 + CS0330)
        //need 5 upperlevels 
        (uppL1 + uppL2 + uppL3 + uppL4 + uppL5) in Registry.upperLevels
        //need 4 electives
        el1 + el2 + el3 + el4 in (CS0320 + Registry.upperLevels + MATH0520)
         //need to fulfill a capstone
        //....
        //....

        (math + alg + ai + sys + uppL1 + uppL2 + uppL3 + uppL4 + uppL5 + el1 + el2 + el3 + el4) in Semester.courses
    }
}

// run fulfilledSCBNew for exactly 7 Semester

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
