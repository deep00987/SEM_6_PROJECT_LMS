const db = require('../../database')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcryptjs')
const { authenticator } = require('otplib')
const validator = require('validator')
require('dotenv').config()
const util = require('util')
const query = util.promisify(db.query).bind(db);

async function registerUser(req, res){
  
    const secret_key = authenticator.generateSecret()
    const dept = {
      'CS' : 1,
      'MATH' : 2,
    }

    let data = req.body
    console.log(req.body)

    if(!data.email || !data.password || !data.fname || !data.lname || !data.department || !data.year){
      console.log("test")
      return res.status(400).json({
        "success": 0, 
        "msg": "Bad request"
      })
    }

      // if(!validator.isEmail(data.email) || !data.password.match(/^([a-zA-Z0-9 _@]+)$/) || !data.fname.match(/^([a-zA-Z]+)$/) || !data.fname.match(/^([a-zA-Z]+)$/)) {
      //   return ({
      //     "success": 0, 
      //     "msg": "bad request"
      //   })
      // }
    
    if (!data.fname.match(/^([a-zA-Z]+)$/)) {
      console.log("test")
      return res.status(400).json({
        "success": 0,
        "msg": "bad name format"
      })
    }

    if (!data.lname.match(/^([a-zA-Z]+)$/)) {
      console.log("test")
      return res.status(400).json({
        "success": 0,
        "msg": "bad name format"
      })
    }
    


    if(!validator.isEmail(data.email)){
      console.log("test")
      return res.status(400).json({
        "success": 0, 
        "msg": "Bad email format"
      })
    }

    if(!data.password.match(/^([a-zA-Z0-9 _@]+)$/)){
      console.log("test")
      return res.status(400).json({
        "success": 0, 
        "msg": "bad password format"
      })
    }
    
    

    
    

    let department = dept[req.body.department]
    const hash = bcrypt.hashSync(data.password, 10);

    const sql = `INSERT INTO student (fname, lname, email, password, dept_id, term_id, auth_secret)
        VALUES (?,?,?,?,?,?,?)
      `
    try {
      const result = await query(sql, [
        data.fname,
        data.lname, 
        data.email,
        hash,
        department,
        data.year,
        secret_key,
      ])
      return res.status(201).json({
        "success": 1,
        "msg": "user created"
      })
    } catch (error) {
      console.log(error)
      return res.status(400).json({
          "success": 0, 
          "msg": "user creation unsuccessful"
      })
    }
    

}


function loginUser(request, response){
    let email = request.body.email
    let pass = request.body.password
    console.log(request.body)
    if(!email || !pass){
        return response.status(400).json({
            "success": 0, 
            "msg": "bad request"
        })
    }else{
        db.query(
            `SELECT student_id, email, password FROM student WHERE email = ?`
            ,[email],
            (err, result,fields)=>{
                if(!err && result.length > 0){
                    console.log(result[0])

                    if(!bcrypt.compareSync(pass, result[0].password)){
                      return response.status(401).json({
                        "success": 0, 
                        "msg": "Login credential doesn't match!"
                      })
                    }else{
                      const token = jwt.sign({
                        id: result[0].student_id,
                        is_staff: false,
                        email: result[0].email,
                        }, 
                        process.env.JWT_SECRET,
                        { expiresIn: '1h' }
                      );
                    
                      console.log(token)
                      response.cookie("JWT_COOKIE",token,{
                          httpOnly: true
                      })
                      return response.status(200).json({
                          "success": 1, 
                          "data": result,
                          "token": token
                      })

                    }
                   
                }else{
                    console.log(err)
                    return response.status(404).json({
                        "success": 0, 
                        "msg": "User not found"
                    })
                }
            }
        )
    }
}

function logoutUser(request, response){
  console.log("working")
  const token = request.cookies.JWT_COOKIE
  if(token){
    response.clearCookie("JWT_COOKIE",{
      httpOnly:true,
    })

    return response.json({
      'msg':"logged out"
    })

  }
  else{
    return response.json({
      'msg':"Something went wrong"
    })
  }
}


module.exports = {loginUser, logoutUser, registerUser}