import database from "../config/database.js"
import jwt from "jsonwebtoken"
import bcrypt from "bcrypt"
import dotenv from "dotenv"

dotenv.config()

export const login = async (req, res) => {
    const username = req.body.username
    const password = req.body.password

    console.log(req.body)
    await getUserCredentials(username)
        .then( foundUser => {
            if (foundUser) {
                bcrypt.compare(password, foundUser.password_hash, (error, matched) => {
                    if (matched) {
                        const token = jwt.sign({
                            username: username,
                            id: foundUser.id
                        }, process.env.JWT_SECRET, {expiresIn: '1h'})
                        console.log(foundUser)
                        res.json({
                            token: token,
                            username: username,
                            fullname: foundUser.fullname,
                            phoneNumber: foundUser.phone_number,
                            address: foundUser.address,
                            email: foundUser.email,
                            latitude: foundUser.latitude,
                            longitude: foundUser.longitude
                        })
                    } else {
                        res.json({
                            message: "Invalid Password",
                            success: false
                        })
                    }
                })
            }
            else {
                res.json({
                    message: `User ${username} does not exist`,
                    success: false
                })
            }
        })
        .catch( error => {
            console.log("Error: ", error)
        })
}

export const register = async (req, res) => {
    try {
        console.log(req.body)
        const {username, password, email} = req.body

        if (await isInDatabase(username)) {
            // 409: Server Conflict
            res.status(409).json({
                message: `Username - ${username} already existed`
            })
        }
        // create a new account
        else {

            if (await isValidEmail(email)) {
                const hashedPassword = await bcrypt.hash(password, 10)
                const result = database.query(
                    'INSERT INTO "Users"(username, email, password_hash) VALUES ($1, $2, $3)',
                    [username, email, hashedPassword])
                // 201: Created
                res.status(201).json({
                    message: `Username - ${username} has been created`
                })
            }
            else {
                // 409: Server Conflict
                res.status(409).json({
                    message: `Email - ${email} is already used by others`
                })
            }
        }
    }
    catch (error) {
        // 500: Server Error
            res.status(500).json({
                message: `Error registering user - ${username}`
            })
    }
}

async function getUserCredentials(username) {
    const result = await database.query(
        'SELECT * FROM "Users" WHERE username = $1',
        [username]
    )
    return result.rows[0]
}

async function isInDatabase(username) {
    const result = await database.query(
        'SELECT * FROM "Users" WHERE username = $1',
        [username]
    )
    return (result.rows.length > 0)
}

async function isValidEmail(email) {
    const result = await database.query(
        'SELECT * FROM "Users" WHERE email = $1',
        [email]
    )
    return (result.rows.length === 0)
}