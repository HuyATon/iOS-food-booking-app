import database from "../config/database.js"


export const getAllMenuItems = async (req, res) => {

    try {
        const result = await database.query(
        `SELECT items.*, res.name as restaurant_name, res.address, AVG(rating)::float8 as average_rating
        FROM "MenuItems" items
        JOIN "Restaurants" res ON items.restaurant_id = res.id
        LEFT JOIN "MenuItemRatings" rating ON items.id = rating.menu_item_id
        GROUP BY items.id, items.restaurant_id, items.name, items.image, items.category, items.description, items.price,
    res.name, res.address
        `)
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

export const getFeedbacksById = async (req, res) => {

    const menuItemId = req.params.id

    await database.query(`
        SELECT users.username, rt.rating, rt.review, rt.created_at
        FROM "MenuItemRatings" rt
        JOIN "Users" users ON users.id = rt.user_id
        WHERE rt.menu_item_id = $1
        `,
        [menuItemId]
    )
        .then( results => {
            console.log(results.rows)
            res.json(results.rows)
        })
        .catch(error => {
            console.log(error)
            res.json({
                message: "Error in retrieving feedbacks of item"
            })
        })
}