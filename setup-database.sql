create table if not exists customer(
customerId integer auto_increment(1000),
username varchar(50) unique not null,
firstName varchar(100),
surname varchar(100),
shippingAddress varchar(500) not null,
emailAddress varchar(250),
password varchar(50),
constraint customer_PK primary key(customerId)
);
 
 
 
create table if not exists product(
productId varchar(20),
name varchar(100) not null,
description varchar(1000) not null,
category varchar(100) not null,
listPrice numeric(10,2) not null,
quantityInStock numeric(4,0) not null,
constraint product_PK primary key(productId)
);

INSERT INTO customer (username, firstName, surname, shippingAddress, emailAddress, password)
VALUES
    ('john_doe', 'John', 'Doe', '123 Elm Street, Springfield, IL, 62704', 'john.doe@example.com', 'password123'),
    ('jane_smith', 'Jane', 'Smith', '456 Oak Avenue, Rivertown, TX, 75001', 'jane.smith@example.com', 'securepass456');


INSERT INTO product (productId, name, description, category, listPrice, quantityInStock)
VALUES
    ('P1001', 'Wireless Mouse', 'A high-precision wireless mouse with ergonomic design.', 'Electronics', 29.99, 150),
    ('P1002', 'Bluetooth Headphones', 'Over-ear Bluetooth headphones with noise-cancellation.', 'Electronics', 89.99, 75),
    ('P2001', 'Office Chair', 'Ergonomic office chair with adjustable height and lumbar support.', 'Furniture', 149.99, 30);