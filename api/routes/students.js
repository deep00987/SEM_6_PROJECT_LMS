
const express = require('express')
const {getUsers, getUserById, geCurrentUser} = require('../controllers/students')
const verifyCookieForApi = require('../../middleware/verifyCookieForApi')
const router = express.Router()
const verifyToken = require("../../middleware/verifyToken")
//debug-- route 
//router.get('/',verifyCookieForApi, getUsers)


router.get('/current',verifyCookieForApi, geCurrentUser)
//router.get('/:id',verifyToken, getUserById)



module.exports = router