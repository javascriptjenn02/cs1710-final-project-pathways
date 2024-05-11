# CS1710 Final Project: Pathways README

## Juan Garcia (jgarci71) and Jennifer Tran (jtran43)

## Project Objective

In this project, we wanted to expand on our course scheduler from curiosity modeling, which created valid carts (carts with courses that don't overlap). In this project, we aim to model a semester plan that can satisfy the concentration requirements in computer science for the AB, ScB, and the respective degrees for the new concentration requirements. Through this, we aimed to prove whether it was possible to find course plans that satisfied both the new concentration and the old concentration.

## Model Design

### Abstraction Choices

One abstraction choice we decided to make was to remove the day of the week and time that a course is offered in a given semester. In our model, any courses offered in the fall can be taken in a fall semester and likewise for the spring.

Another abstraction that we made was remove the pathway specific intermediates for the old concentration requirements. This would have increased the complexity of our model beyond our target goals. Instead, every pathway must fulfill the same categories of intermediate courses (systems, foundations, math).

Other abstractions that were made were omitting winter and summer semesters, overriding, capstoning, graduate level courses, gap semesters, and placement exams for courses (really just CS19). We also reduced certain courses with Honors counterparts to just their regular, and the idea was that wherever a model would suggest someone to take MATH0520, for example, they could substitute it with MATH0540, but our model does not make that substitution. We also decided to not include the Laboratory sections that come with certain courses.

## Signatures and Predicates

### Sigs

#### `Course`

- This abstract sig represents a course in the Concentration.
- It has one field `prereqs` that represents the courses needed before that.
  - `prereqs: set Int -> Course` is a mapping of "buckets" to possible courses. For example, a course like algorithms has the following prereqs.
    ```
      Prerequisites: CSCI 0160, CSCI 0180, or
      CSCI  0190, and one of CSCI 0220, CSCI
      1010, CSCI 1450, MATH 0750, MATH 1010,
      MATH 1530.
    ```
    In our model, this would be represented as the following set:
    ```
        ( (0 CS0200) (0 CS0190)
        (1 CS0220) (1 CS1010) (1 CS1450) )
    ```

#### Individual Course Sigs

In our model, every CS course that is offered in the next academic year is represented as an inheritor of the abstract course sig. For example:

- `one sig CS0150, CS0200, CS1710 extend Course {}`

The one quantifier forces an instance of these courses to exist, while also restricting them to a single instance.

#### `Semester`

- Abstract sig that represents every semester
- Fields

  - `courses: set Course` A set of 2 courses
  - `prev: lone Semester` a pointer to the previous semester
  - `next: lone Semester` a pointer to the next semester

- `sig FallSemester extends Semester {}` represents a fall semester in our model. FallSemesters can only take courses offered in the fall.
- `sig SpringSemester extends Semester {}` represents a spring semester in our model. SpringSemesters can only take courses offered in the Spring.

#### `Registry`

- One sig that represents the registry
- Fields
  - `FallRegistry: set Course` set of all the courses offered int he fall
  - `SpringRegistry: set Course` set of all the courses offered in the spring
  - `intros: set Course` set of all the intro courses
  - `upperLevels: set Course` set of all the 1000+ courses
  - `foundationsInter: set Course` set of the intermediate foundations courses.
  - `mathInter: set Course` set of the intermediate math courses.

#### `PathWays`

- Abstract sig that represents a pathway.
- Fields

  - `core: set Course` represents the core courses in that pathway
  - `related: set Course` represents the related courses in that patway
  - `intermediate: set Course` [SCRAPPED] was meant to represent the pathway specific intermediates

  Pathways are represented as the inheritor of this sig. For example:

  `Design_path, AI_path extends PathWays {}`

### Predicates

#### pred init {}

This predicate is responsible for initializing the model. This involves placing the correct courses in the correct prereqs, registrys, pathways, and levels.

#### pred traces {}

This predicate is responsible for ensuring that the model will only produce valid traces. A valid trace will:

- Constraint semesters to be linear
- Constraint wellformdness for a doubly linked list
- Constraint Semesters to a course load of 2 courses
- Ensure there are no duplicate courses in a plan
- Ensures that semesters alternate
- Constraints the set of courses in a semester to the correct registry (spring or fall)

#### pred fulfilledAB {}

Running this predicate will produce a trace of a course plan that fulfills the old AB requirements. It checks that a pathway and intro sequence has been completed, as well as the intermediate requirements.

#### pred fulfilledScB {}

Running this predicate will produce a trace of a course plan that fulfills the old ScB requirements. It checks that two pathways, intermediates, and an intro sequence have been completed.

#### pred fulfilledABNew {}

Running this predicate will produce a trace of a course plan that fulfilles the new AB requirements.

#### pred fulfilledScBNew {}

Running this predicate will produce a trace of a course plan that fulfills the new ScB requirements.

## Testing

We had tests for the following plan:

- Courses wellformedness
  - a course should not be it's own pre-req
  - we should not be able to get an instance where courses with no pre-reqs have pre-reqs
  - all courses must be one of the sig courses we defined (e.g. all c : Course | c in CS0150 or CS0111 or CS0200 or....)
- CoursesInCorrectRegistry
  - all courses should exist in A registry
- Semesters Linear
  - course should not be it's own next
  - there is only one semester that has no prev
  - there is only one semeter that has no next
  - for every semester with a next field, the next semester has to have that semester as its prev
  - for every semester with a prev field, the prev semester has to have that semester as its next
  - no semester should reach itself
  - next = ~prev (the relation next that points s -> s should be the same as the inverse of prev)
- Semester Course Load Valid
  - sizes 0, 1, 5 are unsat
- Semesters Respect PreReqs
  - it's impossible to take cs200 without taking any of the prereqs
  - test a course with multiple prereqs is sat
- Semesters Courses One Time
  - it's impossible for a course to appear more than once in a study plan

## Running

The bottom of our scheduler.frg file has a series of run statements that produces different traces that satisfy different combinations of requirements. To see an instance, uncomment the desired run statement.

## Challenges

These were some of the challenges we encountered along the way of completing our model, and how we went about solving them

- BitWidth: one of our issues came with checking the size of a course set. We wanted to restrict the size of a set to be 2, but we discovered that the bitwidth issue could cuase instances that pass this constraint but have more than 2 courses. We went about fixing this by adding `for 6 Int` at the end of our run statements

- Linear Semesters: Forge was producing `Semester0, Semester1, Semester2...` but in reality, it would be a random semester like `Semester6` that was the head of our plan. To fix this we added a sig bind, constrianing the next relation to start with Semester0.

- Modeling PreReqs: Our idea for prereqs was simple - let's have a set of Courses, and assert that all the courses in that set must appear in a prior semester. However, this means that for a class like CS0200, you would have to take CS112, CS150, CS170 and CS190. We had two choices: make an abstraction choice or complexify our data structure. We decided to change the prereqs from a set of courses to a set of Int -> Course Mappings, where each int would represent a category of a prereq. See **Sigs** for more
