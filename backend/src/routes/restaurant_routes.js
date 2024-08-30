import express from "express"
const router = express.Router()

import { getAllRestaurants, getRestaurantById } from "../controllers/restaurants_controller.js"

router.get("/", getAllRestaurants)
router.get("/:id", getRestaurantById)

export default router