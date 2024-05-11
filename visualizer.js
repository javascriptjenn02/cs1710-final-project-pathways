const stage = new Stage()

const theArray = instance.signature('Semester')
const fields = theArray.tuples()

const semesterAtom = new AlloyAtom(theArray)

const test = semesterAtom

//const elementsField = instance.signature('Course').tuples()[0]
const elementsField = instance.atom('Semester0')
const elementsField2 = instance.atom('Semester1')
//let alloyf = new AlloyField(elementsField.id(), Course.intSignature(1), instance.field('courses').tuples())
const fieldsreal = (instance.field('courses')).tuples()

let atom_list = []
atom_list.push(fieldsreal)

// Function to sort semesters
function sortSemesters(semesters) {
    // Map to store semesters by their IDs
    const semesterMap = new Map();
    let order = []

    // Add all semesters to the map
    semesters.forEach(semester => {
        const sem_id = semester;
        
        order.push(sem_id)
    });



    return order;
}

stage.add(new TextBox({
  text: sortSemesters(fieldsreal), 
  coords: {x:300, y:300},
  color: 'black',
  fontSize: 8}))
stage.render(svg, document)