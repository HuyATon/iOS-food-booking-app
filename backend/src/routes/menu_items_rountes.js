import express from "express"
const router = express.Router()

import { getAllMenuItems, getMenuItemById, getFeedbacksById } from "../controllers/menu_items_controller.js"

router.get("/", getAllMenuItems)
router.get("/:id", getMenuItemById)
router.get("/:id/feedbacks", getFeedbacksById)

export default router 