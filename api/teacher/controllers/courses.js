const res = require("express/lib/response")
const db = require("../../../database")
const util = require('util')

const query = util.promisify(db.query).bind(db);

async function mapTeacherCourse(req, res){
  const teacher_id = req.body.client.id
  const course_id = req.body.course_id
  let rows;
  let sql = `
    INSERT INTO teacher_course (teacher_id, course_id)
    VALUES (?, ?);
  `

  try {
    console.log(teacher_id, course_id)

    rows = await query(`SELECT teacher_id, course_id FROM teacher_course WHERE teacher_id = ${teacher_id} AND course_id = ${course_id};`)
    
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"cannot enroll into course"
    })
  }

  console.log(rows)
  if(rows.length > 0 && rows[0].teacher_id === teacher_id && rows[0].course_id === course_id){
   
    return res.status(200).json({ 
      "success": 0, 
      "msg": "Already teaching the following course"
    })
  }

  try {
    let result = await query(sql, [teacher_id, course_id])
    return res.status(200).json({ 
      "success": 1, 
      "msg": "Enrolled in this course for teaching"
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

async function unmapTeacherCourse(req, res){
  const teacher_id = req.body.client.id
  const course_id = req.body.course_id
  
  let rows;

  const sql1 = `
    select * from teacher_course where teacher_id = ${teacher_id} AND course_id = ${course_id}
  `
  const sql2 = `
    DELETE FROM teacher_course 
    WHERE teacher_id = ${teacher_id} AND 
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
      "msg": "Teaching info regarding this course is not found"
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

async function getCourses(req, res){
  const teacher = req.body.client.id
  let sql = `
    select course.course_id, course.course_name, course_code 
    from teacher, course, dept_course
    where teacher.dept_id = dept_course.dept_id 
    AND dept_course.course_id = course.course_id
    AND teacher.teacher_id = ${teacher};
  `
  try {
    rows = await query(sql)
    console.log(rows)
    return res.json({"success": 1, "data": JSON.parse(JSON.stringify(rows))})
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success": 0,
      "msg":"something went wrong"
    })
  }

}



module.exports = { getCourses , mapTeacherCourse, unmapTeacherCourse}