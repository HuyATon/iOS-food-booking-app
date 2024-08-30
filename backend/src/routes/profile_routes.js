import express from "express"
const router = express.Router()

import {updateProfile} from "../controllers/profile_controller.js";
import {authenticate} from "../middlewares/authenticate.js";

router.patch("/:username", authenticate, updateProfile)

export default router