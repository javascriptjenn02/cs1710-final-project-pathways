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
// const box = new ImageBox({
//     coords: {x:100,y:100}, 
//     url: "https://1000logos.net/wp-content/uploads/2022/05/Brown-University-Seal.png", 
//     width:200, 
//     height:200})
// stage.add(box)

const box = new ImageBox({
    coords: {x:100,y:100}, 
    url: "https://raw.githubusercontent.com/javascriptjenn02/cs1710-final-project-pathways/6f7d3bd1509f73f34550cbc058f9013e801d2a54/title.svg", 
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
grid0.add({x: 0, y: 0}, new TextBox({text: "Semester 0", fontSize: 15, color: '#006699'}))


let grid1 = new Grid({
    grid_location: {x: 180, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid1.add({x: 0, y: 0}, new TextBox({text: "Semester 1", fontSize: 15, color: '#006699'}))


let grid2 = new Grid({
    grid_location: {x: 280, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid2.add({x: 0, y: 0}, new TextBox({text: "Semester 2", fontSize: 15, color: '#006699'}))

let grid3 = new Grid({
    grid_location: {x: 380, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid3.add({x: 0, y: 0}, new TextBox({text: "Semester 3", fontSize: 15, color: '#006699'}))

let grid4 = new Grid({
    grid_location: {x: 480, y:200},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid4.add({x: 0, y: 0}, new TextBox({text: "Semester 4", fontSize: 15, color: '#006699'}))

let grid5 = new Grid({
    grid_location: {x: 80, y:400},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid5.add({x: 0, y: 0}, new TextBox({text: "Semester 5", fontSize: 15, color: '#006699'}))

let grid6 = new Grid({
    grid_location: {x: 180, y:400},
    cell_size: {x_size: 100, y_size: 30},
    grid_dimensions: {x_size: 1, y_size: 6}
})
grid6.add({x: 0, y: 0}, new TextBox({text: "Semester 6", fontSize: 15, color: '#006699'}))


stage.add(grid0)
stage.add(grid1)
stage.add(grid2)
stage.add(grid3)
stage.add(grid4)
stage.add(grid5)
stage.add(grid6)


addCourseGrid("Semester0", grid0)
addCourseGrid("Semester1", grid1)
addCourseGrid("Semester2", grid2)
addCourseGrid("Semester3", grid3)
addCourseGrid("Semester4", grid4)
addCourseGrid("Semester5", grid5)
addCourseGrid("Semester6", grid6)

stage.add(title)
stage.render(svg, document)