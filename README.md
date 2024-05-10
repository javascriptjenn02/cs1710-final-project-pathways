# CS1710 Final Project: Pathways README 
## Juan Garcia (jgarci17) and Jennifer Tran (jtran43)

## Project Objective 
In this project, we wanted to explore a feature that has been integral and helpful to our experiences as a student. Platforms like Courses at Brown, help students create and explore possible course schedules. However, we wonder what students used prior to the creation of courses at brown. We wanted to explore this through modeling a course scheduler.

After a simple Google search, we learned that course scheduling would happen in person, and people would physically stand in line to sign up. Some people even reported (on reddit) having to call their counselors and telling them which courses they wanted. This means that features on Courses at Brown, like the warning messages that alert students of scheduling conflicts, had to be done manually. This project explores how course schedulers create and approve valid schedules. 

## Model Design
### Abstraction Choices
We decided to create a sig representing a cart, as well as 4 fields in that sig that represent the four courses a student can take. We represent a single course using a Course sig. One of the courses in the cart is a lone sig, representing the option for students to take 3 courses instead of 4. (we don’t pay attention to the overachievers lol). We have the following run statement: 


`run { validCart } for 1 Cart, exactly 4 Course`


This run statement should visualize a valid cart with valid courses. By increasing the number of courses, it is possible to find instances where forge will create a set of courses, and select 4 or 3 that do not overlap. We had an optional predicate, `fourCourses` that expedited the process of visualizing a Cart with 4 courses, as Forge was being exhaustive with the 3 Cart results. Each course has a start and an end arrow, depicting the time at which both occur. We used the default visualization provided by Sterling. 


## Signatures and Predicates
Our model has two sigs, `Course` and `Cart`. Our `Course` sig represents a class in the real world. Our `Cart` sig represents a schedule of classes in the real world. `Course` has two fields, `start` and `end` which model the start and end times of a course. `Cart` has four fields, `course1`, `course2`, `course3`, and `course4`. This represents the possible courses in a cart, where `course4` can be empty or filled. We chose to represent our model with these sigs since a valid cart is comprised of a three or more courses that do not have time conflicts. However, our model is simplified since we did not represent days of the week due time constraints. We have 4 predicates in total. Our `courseDontOverlap` predicate ensures that no classes have the same start or end time. It also permits that one class starts after the other class. The `validCourse` predicate makes it so that all courses start before their end time and that their start time is non negative. Our `validCart` predicate ensures that all courses are valid, there are some three distinct courses that comprise the cart, and that all courses are distinct and do not overlap. Additionally, it allows a cart to have a fourth course. Lastly, we have a `fourCourses` predicate that can be used to only create instances of carts with four classes. `validCourse`, and `coursesDontOverlap` are used for `validCart` to ensure that each `Course` does break time rules.


## Testing
We wrote tests for three different predicates. We wanted to verify the lower level predicates, as well as our more robust validCart predicate. We begun with testing valid courses, this was done mostly through examples and test expect blocks. In testing valid courses, we realized that something we had not considered before was that it was possible for courses to be invalid and not exist in the cart. This was something that had to be fixed, so now we have a call to valid course that ensures are courses are valid when running valid cart. 
To test `coursesDontOverlap`, we utilized assert statements and expect blocks. To ensure that a course does not overlap, we created testing predicates that enforced the fact that courses had to have different start and end times, and that no two classes occurred at the same time. We asserted that each of these predicates were necessary for `coursesDontOverlap`. Similarly, we had assert statements that ensured our `coursesDontOverlap` was communicative, that is, if `coursesDontOverlap[c1,c2]` is true, then `coursesDontOverlap[c2,c1]` must be true as well. Our test expect blocks test that there are instances where `coursesDontOverlap` and `validCart` are satisfiable. To ensure that we are not overconstraining, we use test our methods with `some` and `all`. This is because we want to ensure that there are instances where there are some courses that overlap, but still result in a valid cart since all courses in the cart do not overlap with each other. We use example test blocks to check whether or not instances of our sigs satisfy the `coursesDontOverlap` predicate.
When it came to testing validCart, we started with testing the properties of the cart as being necessities to the validCart predicate passing. We did this through asserts, and by testing the individual properties (validCourses and no overlaps) Asserting the subproperties was a great way to check if we were performing any overconstraints by running an exhaustive search. 
One of the challenges that we ran into when it came to modeling our cart was revealed during testing. In checking the number of courses, we wanted to take the number of courses that are reachable from the cart, which led to a really long reachable statement. This is not extensible at all. If we wanted to represent every course in a department, for example, this would be really inefficient. A set, however, would be a single field. Additionally, in relational forge, it would be possible to interpret each cart as a subset of the entire set of available courses


