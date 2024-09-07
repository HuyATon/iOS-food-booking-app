import express from "express"
const router = express.Router()

import { createBooking, getUserBookings, createFeedback } from "../controllers/booking_controller.js";
import { authenticate } from "../middlewares/authenticate.js";


router.post("/", authenticate, createBooking)

router.get("/", authenticate, getUserBookings)

router.post("/feedbacks", authenticate, createFeedback)


export default router