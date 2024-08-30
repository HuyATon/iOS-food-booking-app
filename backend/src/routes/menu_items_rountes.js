import express from "express"
const router = express.Router()

import { getAllMenuItems, getMenuItemById } from "../controllers/menu_items_controller.js"

router.get("/", getAllMenuItems)
router.get("/:id", getMenuItemById)

export default router