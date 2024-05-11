#lang forge
open "scheduler.frg"


 pred notInPreReqs {
    all s : Semester {
        all c : s.courses | {
            c not in (c.prereqs).Course
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


test suite for fulfilledAB {
    assert notInPreReqs is necessary for fulfilledAB for exactly 7 Semester, 6 Int
    assert courseinRegistry is necessary for fulfilledAB for exactly 7 Semester, 6 Int
    test expect {courseNoPrereq : {some c : Course | {notInPrereqs}} is sat}
    assert noDuplicates is necessary for fulfilledAB for exactly 7 Semester, 6 Int
   

}

test suite for fulfilledScB {
    assert notInPreReqs is necessary for fulfilledScB for exactly 7 Semester, 6 Int
    assert courseinRegistry is necessary for fulfilledScB for exactly 7 Semester, 6 Int
    assert noDuplicates is necessary for fulfilledScB for exactly 7 Semester, 6 Int
}

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
    test expect {courseLoadInvalidSmall : {some s : Semester | {
        semestersCourseLoadSmall
        traces
        }} for exactly 6 Int is unsat} 

    test expect {courseLoadInvalidLarge : {some s : Semester | {
        semestersCourseLoadLarge
        traces
        }} for exactly 6 Int is unsat} 

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
        (CS0150 not in Semester.courses) and (CS0170 not in Semester.courses) and (CS0112 not in Semester.courses) and (CS0111 not in Semester.courses)

    } 

    pred badMultiplePrereqs {
        init
        CS1410 in Semester.courses
        all prereq : (CS1410.prereqs).Course | {
            some category : prereq.(CS1410.prereqs) | category not in (Semester.^prev).courses
        } 

    } 
    
  
  test suite for introSat {
        test expect {introInCourse : {some s : Semester | {
            hasPrereqForIntro
            introSat
        }} for exactly 7 Semester is sat} 

        test expect {no200Prereq : {some s : Semester | {
            bad200
            introSat
            semestersRespectPreReqs
        }} for exactly 7 Semester, 6 Int is unsat} 
  }

  test suite for semestersRespectPreReqs {
    test expect {no200Prereq : {some s : Semester | {
        badMultiplePrereqs
        semestersRespectPreReqs
    }} for exactly 7 Semester, 6 Int is unsat} 

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
    assert noSemesterIsItsOwnNext is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - there is only one semester that has no prev
    assert oneSemesterIsTheHead is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - there is only one semeter that has no next
    assert oneSemesterIsTheTail is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - for every semester with a next field, the next semester has to have that semester as its prev
    assert allSemestersNextIsPrev is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - for every semester with a prev field, the prev semester has to have that semester as its next
    assert allSemestersPrevIsNext is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - no semester should reach itself
    assert noSemesterIsReachableFromSelf is necessary for semestersLinear for exactly 7 Semester, 6 Int
//     - next = ~prev (the relation next that points s -> s should be the same as the inverse of prev)
    assert semestersLinear is sufficient for transposeOfNextIsPrev for exactly 7 Semester, 6 Int
}


    
