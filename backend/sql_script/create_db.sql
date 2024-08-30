CREATE TABLE "Users" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    fullname VARCHAR,
    email VARCHAR UNIQUE NOT NULL,
    username varchar UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR,
    latitude FLOAT,
    longitude FLOAT,
    address VARCHAR
);

CREATE TABLE "Restaurants" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    phone_number VARCHAR NOT NULL,
    description TEXT
);

CREATE TABLE "MenuItems" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(id),
    name VARCHAR NOT NULL,
    image VARCHAR NOT NULL,
    category VARCHAR NOT NULL,
    rating FLOAT,
    description TEXT,
    price DECIMAL NOT NULL
);

CREATE TABLE "Bookings" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id INT REFERENCES Users(id),
    restaurant_id INT REFERENCES Restaurants(id),
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE "Orders" (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    booking_id INT REFERENCES Bookings(id),
    menu_item_id INT REFERENCES MenuItems(id),
    quantity INT NOT NULL
);
