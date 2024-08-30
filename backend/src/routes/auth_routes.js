import express from "express"
const router = express.Router()


import {register, login} from "../controllers/authentication_controller.js"

// Login route
router.post('/login', login)

// Register route
router.post('/register', register)

export default router