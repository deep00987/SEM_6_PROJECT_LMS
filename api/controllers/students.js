const res = require('express/lib/response')
const db = require('../../database')

function getUsers(req, res){
    const sql = `SELECT * FROM student`
    db.query(sql, (err, result, fields)=>{
        if(!err){
            return res.status(200).json({
                'success': 1,
                'data': result
            })
            
        }else{
            return res.status(500).json({
                'success': 0,
                'data': ''
            })
        }
    })
}
function getUserById(req, res){
    let data = req.params.id
    console.log(req.body.client)
    const sql = `SELECT * FROM student WHERE student_id = ${data}`
    db.query(sql, (err, result, fields)=>{
        if(!err && result.length > 0){
            //console.log(result.length)
            return res.status(200).json({
                'success': 1,
                'data': result
            })
            
        }else{
            console.log(err)
            return res.status(500).json({
                'success': 0,
                'data': ''
            })
        }
    })
}   


function geCurrentUser(req, res){
  let student_ID = req.body.client.id
  console.log(req.body)
  const sql = `SELECT fname, lname, dept_id, term_id, student_id, email FROM student WHERE student_id = ${student_ID}`
  db.query(sql, (err, result, fields)=>{
      if(!err && result.length > 0){
          //console.log(result.length)
          return res.status(200).json({
              'success': 1,
              'data': result
          })
          
      }else{
          console.log(err)
          return res.status(500).json({
              'success': 0,
              'data': ''
          })
      }
  })
}   








module.exports =  {getUsers, getUserById, geCurrentUser} 