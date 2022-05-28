const res = require("express/lib/response")
const db = require("../../database")
const bcrypt = require('bcryptjs')
const util = require('util');
const { append } = require("express/lib/response");


const query = util.promisify(db.query).bind(db);

async function updateEmail(req, res){
  const student_id = req.body.client.id
  const email = req.body.email;
  let rows;
  
  let sql1 = `
    select * from student where email = '${email}';
  `
  let sql2 = `
    UPDATE student 
    SET email = '${email}'
    WHERE student_id = ${student_id};
  `

  
 

  // //update term
  try {
    rows = await query(sql1)
    console.log(rows)
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success" : 0, 
      "msg" : "something went wrong"
    })
  }

  if(rows.length > 0 ){
    return res.status(400).json({
      "success" : 0, 
      "msg" : "email is already taken or in use"
    })
  }else{
    try {
      rows = await query(sql2)
      console.log(rows)
      return res.status(200).json({
        "success" : 1, 
        "msg" : "email Updated"
      })
    } catch (error) {
      console.log(error)
      return res.status(400).json({
        "success" : 0, 
        "msg" : "something went wrong"
      })
    }
  }

  
}


async function updatePasswd(req, res){
  const student_id = req.body.client.id
  const password = req.body.password;
  let rows;
  
  const hash = bcrypt.hashSync(password, 10)
 
  let sql1 = `
    UPDATE student 
    SET password = '${hash}'
    WHERE student_id = ${student_id};
  `


  // //update term
  try {
    rows = await query(sql1)
    console.log(rows)
    return res.status(400).json({
      "success" : 1, 
      "msg" : "Password updated"
    })
  } catch (error) {
    console.log(error)
    return res.status(400).json({
      "success" : 0, 
      "msg" : "something went wrong"
    })
  }

  
  
}






module.exports = {updateEmail, updatePasswd}