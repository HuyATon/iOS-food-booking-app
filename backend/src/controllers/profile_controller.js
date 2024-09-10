import database from "../config/database.js"
import dotenv from "dotenv"

dotenv.config()


export const updateProfile = async (req, res) => {

    console.log(req.body)
    try {
        console.log(req.body)
        const { username } = req.params
        const { fullname, phoneNumber, latitude, longitude, address } = req.body

        const result = await database.query(
            `UPDATE "Users"
            SET fullname = $1,
                phone_number = $2,
                longitude = $3,
                latitude = $4,
                address = $5
            WHERE username = $6`,
            [fullname, phoneNumber, longitude, latitude, address, username]
        )
        if (result.rowCount === 1) {
            res.status(200).json({
                message: `Updated profile ${username} in database`,
                success: true
            })
        } else {
            res.status(401).json({
                message: `Log in session is invalid`,
                success: false
            })
        }
    }
    catch {
        res.status(500).json({
            message: "Server error",
            success: false
        })
    }

}