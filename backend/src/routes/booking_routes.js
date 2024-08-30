import express from "express"
const router = express.Router()

import { createBooking, getUserBookings } from "../controllers/booking_controller.js";
import { authenticate } from "../middlewares/authenticate.js";

router.post("/", authenticate, createBooking)

router.get("/", authenticate, getUserBookings)


export default router