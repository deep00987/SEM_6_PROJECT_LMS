

const login_btn = document.querySelector(".myform-btn-login")
const reg_btn = document.querySelector(".myform-btn")

login_btn.addEventListener('click', goToLogin.bind())
reg_btn.addEventListener('click', processRegisterForm.bind())

function goToLogin(e){
  window.location.href = '/login'
}

function processRegisterForm(e){
  const fname = document.getElementById("form__fname").value
  const lname = document.getElementById("form__lname").value
  const email = document.getElementById("form__email").value
  const dept =  document.getElementById("form__dept").value
  const term =  document.getElementById("form__term").value
  const password = document.getElementById("form__pass").value
  const c_pass = document.getElementById("form__pass__confirm").value

  e.preventDefault()

  console.log(fname, lname, email, dept, term, password, c_pass)
  if(!(fname&&lname&&email&&dept&&term&&password&&c_pass)){
    alert("please fill our all the fields")
   
    return
  }

  if(password !== c_pass){
    alert("both password must be same")
   
    return
  }

  registerNewUser(fname,lname,email,dept,term, password);

 
  console.log(e)
}

function registerNewUser(fname,lname,email,dept,term,password){
  //console.log(fname,lname)
  let data = {
    fname,lname,email,department:dept,year:term,password
  }
  console.log(data)
  
  fetch("/api/auth/register/",{
    method:"POST",
    headers: {
      'content-type':'application/json'
    },
    body: JSON.stringify(data)
  })
  .then(response => response.json())
  .then(data=>{
    console.log(data)
    if(!data.success){
      alert(`${data.msg}`)
    }else{
      alert("user created successfully")
      window.location.href = '/login'
    }
  })
  .catch(err =>{
    console.log(err)
    throw err
  })
}