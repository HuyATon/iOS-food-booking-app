import database from "../config/database.js"


export const getAllMenuItems = async (req, res) => {

    try {
        const result = await database.query(
        `SELECT items.*, res.name as restaurant_name, res.address
        FROM "MenuItems" items
        JOIN "Restaurants" res ON items.restaurant_id = res.id`)
        res.json(result.rows)
    }
    catch (error) {

        console.log(error)
        res.json({
            message: `Error: ${error}`
        })
    }
}

export const getMenuItemById = async (req, res) => {
    const id = req.params.id
    try {
        const result = await database.query(`SELECT * FROM "MenuItems" WHERE id = $1`, [id])
        res.json(result.rows[0])
    }
    catch (error) {

        res.json({
            message: `Error: ${error}`
        })
    }
}