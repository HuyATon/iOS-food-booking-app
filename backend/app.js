import express from "express"
import bodyParser from "body-parser"
import routes from "./routes.js"


const app = express();
const port = 3000;

// Middlewares
app.use(express.json())
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use("/", routes)


app.listen(port, () => {
    console.log(`Server has been started on http://localhost:${port}`)
})
