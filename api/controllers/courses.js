const res = require("express/lib/response")
const db = require("../../database")
const util = require('util')

const query = util.promisify(db.query).bind(db);

async function mapStudentCourse(req, res){
  const student_id = req.body.client.id
  const course_id = req.body.course_id
  let rows;
  let sql = `
    INSERT INTO student_course (student_id, course_id)
    VALUES (?, ?);
  `

  try {
    console.log(student_id, course_id)

    rows = await query(`SELECT student_id, course_id FROM student_course WHERE student_id = ${student_id} AND course_id = ${course_id};`)
    
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"cannot enroll into course"
    })
  }

  console.log(rows)
  if(rows.length > 0 && rows[0].student_id === student_id && rows[0].course_id === course_id){
   
    return res.status(200).json({ 
      "success": 0, 
      "msg": "already enrolled in the following course"
    })
  }

  try {
    let result = await query(sql, [student_id, course_id])
    return res.status(200).json({ 
      "success": 1, 
      "msg": "Enrolled"
    })
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"cannot enroll into course"
    })
  }

}

//delete entry from student course 

async function unmapStudentCourse(req, res){
  const student_id = req.body.client.id
  const course_id = req.body.course_id
  
  let rows;

  const sql1 = `
    select * from student_course where student_id = ${student_id} AND course_id = ${course_id}
  `
  const sql2 = `
    DELETE FROM student_course 
    WHERE student_id = ${student_id} AND 
    course_id = ${course_id};
  `

  try {
    rows = await query(sql1)
    console.log(rows)
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"something went wrong"
    })
  }

  //check if course requested, exist or not
  if(rows.length === 0){
    return res.status(404).json({
      "success": 0,
      "msg": "Enrollment info regarding this course is not found"
    })
  }

  try {
    rows = await query(sql2)
    console.log(rows)
    return res.json({"success": 1, "msg": "opted out off the course sucessfully"})
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"something went wrong"
    })
  }
  
}


module.exports = {mapStudentCourse, unmapStudentCourse}