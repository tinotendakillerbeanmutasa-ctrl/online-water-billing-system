CREATE DATABASE IF NOT EXISTS water_billing;
USE water_billing;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('customer','admin','staff') DEFAULT 'customer'
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(20),
    balance DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    bill_date DATE NOT NULL,
    consumption DECIMAL(10,2) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('unpaid','paid') DEFAULT 'unpaid',
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE password_resets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    token VARCHAR(255),
    expires_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE audit_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(255),
    details TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Sample admin and customer
INSERT INTO users (username, fullname, password, role) VALUES
('admin', 'Admin User', MD5('admin123'), 'admin'),
('johndoe', 'John Doe', MD5('password123'), 'customer');

INSERT INTO customers (user_id, address, phone, balance) VALUES (2, '123 Main St', '263771234567', 0);

-- Sample bill
INSERT INTO bills (customer_id, bill_date, consumption, amount, status) VALUES
(1, '2025-09-01', 20.5, 41.00, 'unpaid');