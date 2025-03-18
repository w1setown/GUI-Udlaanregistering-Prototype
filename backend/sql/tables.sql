CREATE TABLE user_position(
    id INT AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR(100),
    comment VARCHAR(100)
);

CREATE TABLE computer(
    id INT AUTO_INCREMENT PRIMARY KEY,
    fabricator VARCHAR(50),
    model VARCHAR(50),
    mousetype VARCHAR(20),
    status VARCHAR(20),
    wear VARCHAR(50)
);

CREATE TABLE user(
    id INT AUTO_INCREMENT PRIMARY KEY,
    position_id INT,
    name VARCHAR(100),
    address VARCHAR(100),
    zip INT,
    city VARCHAR(50),
    cpr INT,
    email VARCHAR(100),
    class VARCHAR(10),
    is_blacklisted TINYINT(1),
    FOREIGN KEY (position_id) REFERENCES user_position(id) ON DELETE CASCADE
);

CREATE TABLE reservation_line(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    computer_id INT,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (computer_id) REFERENCES computer(id) ON DELETE CASCADE
);

CREATE TABLE reservation(
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_line_id INT,
    endDate DATE,
    reservationDate DATE,
    status VARCHAR(20),
    FOREIGN KEY (reservation_line_id) REFERENCES reservation_line(id) ON DELETE CASCADE
);

CREATE TABLE loan_line(
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    computer_id INT,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    FOREIGN KEY (computer_id) REFERENCES computer(id) ON DELETE CASCADE
);

CREATE TABLE loan(
    id INT AUTO_INCREMENT PRIMARY KEY,
    loan_line_id INT,
    reservation_id INT,
    loanDate DATE,
    returnedDate DATE,
    expDate DATE,
    status VARCHAR(20),
    FOREIGN KEY (loan_line_id) REFERENCES loan_line(id) ON DELETE CASCADE,
    FOREIGN KEY (reservation_id) REFERENCES reservation(id) ON DELETE CASCADE 
);
