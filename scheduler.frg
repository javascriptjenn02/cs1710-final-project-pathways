#lang forge/bsl

/**
this is the courses sig, it represents a single course with a start and an end time. 
**/
sig Course {
    start: one Int,
    end: one Int
}

/*
* This is the Cart sig, it has four fields for 4 different courses. One of the fields is lone, 
* meaning that 3 course carts are possible
*/
one sig Cart {
    course1: one Course,
    course2: one Course,
    course3: one Course,
    course4: lone Course
}


/**
*This predicate ensues that two courses don't overlap.
**/
pred coursesDontOverlap[c1, c2: Course] {
    c1.start != c2.start
    c1.end != c2.end
    //rather than writing what is not allowed, we can express this predicate in a way that only 
    //allows what is allowed. 
    (c1.start >= c2.end or c2.start >= c1.end)
}

/**
* This predicate ensures that all courses are wellformed. An alternate approach would be a preidcate that
* takes in a single course and validates it as wellformed. 
*/
pred validCourse {
    all c: Course {
        c.start < c.end 
        c.start >= 0
    }
}

/**
* This is the predicate that forms what a valid cart is. It checks that courses are valid and that 
* all of its courses do not overlap with each other. 
*/
pred validCart {
 {validCourse}
 all c: Cart {
    some disj c1, c2, c3 : Course {
        c.course1 = c1
        c.course2 = c2
        c.course3 = c3
        coursesDontOverlap[c1, c2]
        coursesDontOverlap[c1, c3]
        coursesDontOverlap[c2, c3]
        some c.course4 implies {
            c.course4 != c.course1
            c.course4 != c.course2
            c.course4 != c.course3
            coursesDontOverlap[c1, c.course4]
            coursesDontOverlap[c2, c.course4]
            coursesDontOverlap[c3, c.course4]
        }
    }
 }
}

/**
* this predicate was used to explore our model. We weren't getting 4 course Carts at first so we forced 
* an instance by including this in the run statement. 
*/
pred fourCourses {
    all c: Cart {
        some c.course1
        some c.course2
        some c.course3
        some c.course4
    }
}
//this gives us a valid cart. 
run { validCart } for 1 Cart, exactly 4 Course
