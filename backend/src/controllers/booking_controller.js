import database from "../config/database.js"

export const createBooking = async (req, res) => {
    console.log("Go to post booking")
    try {
        const orders = req.body
        const user_id = req.user.id

        let restaurantIds = new Set()
        orders.forEach( order => {
            restaurantIds.add(order.restaurantId)
        })

        let restaurantIdToBookingId = new Map()

        for (const restaurantId of restaurantIds) {
            const result = await database.query(
                `INSERT INTO "Bookings"(user_id, restaurant_id) VALUES ($1, $2) RETURNING id`,
                [user_id, restaurantId]
            ) 
            const newBookingId = result.rows[0].id
            restaurantIdToBookingId[`${restaurantId}`] = newBookingId
            
        }
        for (const order of orders) {
            const { menuItemId, restaurantId, quantity} = order
            const bookingId = restaurantIdToBookingId[`${restaurantId}`]
            await database.query(
                `INSERT INTO "Orders"(booking_id, menu_item_id, quantity) VALUES ($1,$2,$3)`,
                [bookingId, menuItemId, quantity]
            )
        }

        res.json({
            message: "Successfully place the orders"
        })
    }
    catch (error) {
        res.json({
            message: `Error ${error}`
        })
    }
}

export const getUserBookings = async (req, res) => {

    const userId = req.user.id
    try {
        const result = await database.query(
            `SELECT
            bk.id as id,
            res.name as restaurant_name,
            item.name as item_name,
            item.image as image,
            item.price as price,
            od.quantity as quantity
            FROM "Bookings" bk
            JOIN "Orders" od ON bk.id = od.booking_id
            JOIN "Restaurants" res ON bk.restaurant_id = res.id
            JOIN "MenuItems" item ON od.menu_item_id = item.id
            WHERE bk.user_id = $1
            ORDER BY bk.booking_time DESC
            `,
            [userId]
        )
        if (result.rowCount == 0) {
            res.json([])
        }
        else {
            const bookingsMap = new Map()
            result.rows.forEach(booking => {
                console.log(booking)
                const {id, restaurant_name, item_name, image, price, quantity} = booking

                if (!bookingsMap[id]) {
                    bookingsMap[id] = {
                        id,
                        restaurant_name,
                        orders: []
                    }
                }
                bookingsMap[id].orders.push({
                    item_name,
                    image,
                    price,
                    quantity
                })
            })
            const bookingsArray = Object.values(bookingsMap)
            console.log("Return data:", bookingsArray)
            res.json(bookingsArray)
        }
    }
    catch (error) {
        console.log(error)
        res.json({
            message: "Server errors occur in query user bookings"
        })
    }
}



async function getUserId(username) {

    try {
        const result = database.query(`SELECT * FROM "Users" WHERE username = ${username}`)
        return result.rows[0]
    }
    catch (error) {
        throw error
    }
}