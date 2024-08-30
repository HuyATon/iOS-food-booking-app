import jwt from "jsonwebtoken"

const secretKey = process.env.JWT_SECRET

export const authenticate = (req, res, next) => {
    const authHeader = req.headers['authorization']

    //console.log("Header", authHeader)
    if (!authHeader) {
        return res.status(401).json( {
            message: "No token provided",
            success: false
        } )
    }
    const token = authHeader.split(' ')[1] // "Bearer TOKEN_STRING"
    //console.log("Token:", token)
    try {
        const decoded = jwt.verify(token, secretKey)
        req.user = decoded
        console.log(req.user)
        next()
    }
    catch (error) {
        return res.status(401).json( {
            message: "Failed to authenticate token",
            success: false
        } )
    }
}