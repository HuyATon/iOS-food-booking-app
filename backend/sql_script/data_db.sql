-- Restaurant
INSERT INTO "Restaurants" (name, address, phone_number, description)
VALUES 
('The Gourmet Bistro', '123 Culinary Street, Food City', '555-1234', 'A cozy bistro offering a fine selection of gourmet dishes.'),
('Sushi Paradise', '456 Ocean Avenue, Seaside Town', '555-5678', 'A top-rated sushi restaurant known for its fresh ingredients and artistic presentations.');

-- MenuItems
INSERT INTO "MenuItems" (restaurant_id, name, image, category, rating, description, price)
VALUES 
(2, 'Vegetarian Soup', 'vegetarian_soup', 'Food', 4.5, 'A hearty vegetarian soup filled with fresh vegetables and aromatic herbs.', 8),
(1, 'Chicken Soup', 'chicken_soup', 'Food', 4.7, 'A comforting chicken soup with tender chicken pieces and vegetables.', 9),
(1, 'Grilled Chicken', 'grilled_chicken', 'Food', 4.8, 'Juicy grilled chicken seasoned with a blend of spices.', 12),
(2, 'Noodle', 'noodle', 'Food', 4.3, 'A bowl of savory noodles with vegetables and a flavorful broth.', 7),
(1, 'Bread', 'bread', 'Food', 4.0, 'Freshly baked bread with a crisp crust and soft interior.', 3),
(1, 'Pizza', 'pizza', 'Food', 4.6, 'Classic pizza with a variety of toppings and a crispy crust.', 10),
(1, 'Fried Chicken', 'fried_chicken', 'Food', 4.5, 'Crispy fried chicken with a juicy interior.', 11),
(2, 'Seafood Soup', 'seafood_soup', 'Food', 4.7, 'A rich seafood soup with shrimp, fish, and vegetables.', 13),
(1, 'Sprite', 'sprite', 'Drinks', 4.2, 'Refreshing lemon-lime soda.', 2),
(1, 'Pepsi', 'pepsi', 'Drinks', 4.3, 'Classic cola beverage.', 2),
(1, 'Black Coffee', 'coffee', 'Drinks', 4.3, 'Full of caffeine.', 2),
(1, 'Ice Cream', 'ice_cream', 'Dessert', 4.3, 'Full of sweetness and chocolate flavor.', 2);
