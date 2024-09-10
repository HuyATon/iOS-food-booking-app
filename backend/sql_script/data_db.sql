-- Restaurant
INSERT INTO "Restaurants" (name, address, phone_number, description)
VALUES 
('The Gourmet Bistro', '123 Culinary Street, Food City', '555-1234', 'A cozy bistro offering a fine selection of gourmet dishes.'),
('Sushi Paradise', '456 Ocean Avenue, Seaside Town', '555-5678', 'A top-rated sushi restaurant known for its fresh ingredients and artistic presentations.');

-- MenuItems
INSERT INTO "MenuItems" (restaurant_id, name, image, category, description, price)
VALUES 
(2, 'Vegetarian Soup', 'vegetarian_soup', 'Food', 'A hearty vegetarian soup filled with fresh vegetables and aromatic herbs.', 8),
(1, 'Chicken Soup', 'chicken_soup', 'Food', 'A comforting chicken soup with tender chicken pieces and vegetables.', 9),
(1, 'Grilled Chicken', 'grilled_chicken', 'Food', 'Juicy grilled chicken seasoned with a blend of spices.', 12),
(2, 'Noodle', 'noodle', 'Food', 'A bowl of savory noodles with vegetables and a flavorful broth.', 7),
(1, 'Bread', 'bread', 'Food', 'Freshly baked bread with a crisp crust and soft interior.', 3),
(1, 'Pizza', 'pizza', 'Food', 'Classic pizza with a variety of toppings and a crispy crust.', 10),
(1, 'Fried Chicken', 'fried_chicken', 'Food', 'Crispy fried chicken with a juicy interior.', 11),
(2, 'Seafood Soup', 'seafood_soup', 'Food', 'A rich seafood soup with shrimp, fish, and vegetables.', 13),
(1, 'Sprite', 'sprite', 'Drinks', 'Refreshing lemon-lime soda.', 2),
(1, 'Pepsi', 'pepsi', 'Drinks', 'Classic cola beverage.', 2),
(1, 'Black Coffee', 'coffee', 'Drinks', 'Full of caffeine.', 2),
(1, 'Ice Cream', 'ice_cream', 'Dessert', 'Full of sweetness and chocolate flavor.', 2);