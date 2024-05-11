const stage = new Stage() 

const course_field = instance.field('courses').tuples()

console.log(course_field[0].atoms()[1].id()) //THIS GETS THE COURSE
console.log(course_field[0].atoms()[0].id()) //THIS GETS THE SEMESTER

// ---------------------------------- INSTANCE FUNCTIONS ---------------------------------- //
let course_list = {}
function populateSemCourses(sem_course_tuple) {

    for(let i = 0; i < sem_course_tuple.length; i++){
        let semester = sem_course_tuple[i].atoms()[0].id()
        let course_name = sem_course_tuple[i].atoms()[1].id()

        if (!course_list[semester]){
            course_list[semester] = []
        }
        course_list[semester].push(course_name)
    }
    //return course_list
    //return course_list["Semester2"]
    //return Object.entries(course_list)[0]
    //return Object.keys(course_list)
}

function addCourseGrid(semester, grid){
    c = course_list[semester]
    for(i = 0; i < c.length; i++){
        grid.add({x: 0, y: i+1}, new TextBox({text: c[i], fontSize: 12, color: 'black'}))
    }
}

populateSemCourses(course_field)

// ---------------------------------- MAKING SVG OBJECTS ---------------------------------- //
const box = new ImageBox({
    coords: {x:100,y:100}, 
    url: "https://1000logos.net/wp-content/uploads/2022/05/Brown-University-Seal.png", 
    width:200, 
    height:200})
stage.add(box)

const title = new TextBox({
    text: "Brown University CS Course Plan 🙈 ",
    coords: {x:310,y:100},
    color: 'black',
    fontSize: 20
})

// ---------------------------------- MAKING GRID OBJECTS ---------------------------------- //
let grid0 = new Grid({
    grid_location: {x: 80, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid0.add({x: 0, y: 0}, new TextBox({text: "Semester 0", fontSize: 12, color: ''}))


let grid1 = new Grid({
    grid_location: {x: 180, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid1.add({x: 0, y: 0}, new TextBox({text: "Semester 1", fontSize: 12, color: ''}))


let grid2 = new Grid({
    grid_location: {x: 280, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid2.add({x: 0, y: 0}, new TextBox({text: "Semester 2", fontSize: 12, color: ''}))



// stage.add(grid)
// stage.add(grid2)


addCourseGrid("Semester0", grid0)
addCourseGrid("Semester1", grid1)
addCourseGrid("Semester2", grid2)

stage.add(new TextBox({
  text: course_list["Semester6"], 
  coords: {x:200, y:500},
  color: 'black',
  fontSize: 8}))
stage.add(title)
stage.render(svg, document)