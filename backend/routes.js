import express from "express"
import authRoutes from "./src/routes/auth_routes.js";
import profileRoutes from "./src/routes/profile_routes.js";
import restaurantsRoutes from "./src/routes/restaurant_routes.js"
import menuItemsRoutes from "./src/routes/menu_items_rountes.js"
import bookingRoutes from "./src/routes/booking_routes.js"

const router = express.Router()


router.use("/auth", authRoutes)
router.use("/profile" ,profileRoutes)
router.use("/restaurants", restaurantsRoutes)
router.use("/menuItems", menuItemsRoutes)
router.use("/booking", bookingRoutes)


export default router