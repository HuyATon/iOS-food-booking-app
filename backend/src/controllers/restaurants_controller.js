import database from "../config/database.js"


export const getAllRestaurants = async(req, res) => {

    try {
        const result = await database.query(`SELECT * FROM "Restaurants"`)

        res.json(result.rows)
    }
    catch (error) {
        res.json({
            message: `Error: ${error}`
        })
    }
}
export const getRestaurantById = async(req, res) => {
    const id = req.params.id
    try {
        const result = await database.query(`SELECT * FROM "Restaurants" WHERE id = $1`, [id])
        res.json(result.rows[0])
    }
    catch (error) {
        res.json({
            message: `Error: ${error}`
        })
    }
}