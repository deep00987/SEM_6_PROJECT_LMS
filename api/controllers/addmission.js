const res = require("express/lib/response")
const db = require("../../database")
const util = require('util');


const query = util.promisify(db.query).bind(db);

async function getAddmission(req, res){
  const student_id = req.body.client.id
  const term_id = req.body.term_id;
  let rows;
  
  let sql1 = `
    select term_id from student where student_id = ${student_id}
  `
  let sql2 = `
    delete from student_course where student_id = ${student_id}
  `

  let sql3 = `
    UPDATE student 
    SET term_id = ${term_id}
    where student_id = ${student_id};
  `

  try {
    rows = await query(sql1)
  } catch (error) {
    console.log(error)
    return res.status(404).json({
      "success": 0,
      "msg": "something went wrong"
    })
  }

  if(rows.length > 0 && rows[0].term_id === term_id ){
    return res.status(400).json({
      "success": 0,
      "msg": "Already addmited in this term"
    })
  }
  
  //delete courses of the previes term mapped with this user
  try {
    rows = await query(sql2)
    console.log(rows)
  } catch (error) {
    console.log(error)
    return res.status(404).json({
      "success": 0,
      "msg": "something went wrong"
    })
  }

  //update term
  try {
    rows = await query(sql3)
    console.log(rows)
    return res.status(200).json({
      "success": 1,
      "msg": "Addmission successful"
    })
  } catch (error) {
    console.log(error)
    return res.status(404).json({
      "success": 0,
      "msg": "something went wrong"
    })
  }

  
}

module.exports = {getAddmission}