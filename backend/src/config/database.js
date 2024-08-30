import pg from "pg";
import dotenv from "dotenv"

dotenv.config()

const database = new pg.Client({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
})

// Connect to the database
async function connectDB() {
    try {
        await database.connect();
        console.log('Connected to PostgreSQL database successfully.');
    } catch (err) {
        console.error('Error connecting to PostgreSQL database:', err);
        process.exit(1); // Exit process if connection fails
    }
}

// Call the connect function
await connectDB();

export default database