# Database Schema Documentation

This document provides comprehensive information about the database structure for the Udlånsregistrering System (Laptop Loan Registration).

## Overview

The database is designed to efficiently track and manage laptop loans, users, and equipment inventory. It uses a relational structure with multiple interconnected tables to maintain data integrity and support complex queries.

## Database Tables

### 1. user

Stores information about system users (students).

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| position_id | int(11) | Foreign key to user_position |
| name | varchar(100) | User's full name |
| address | varchar(100) | User's address |
| zip | int(11) | Postal code |
| city | varchar(50) | City |
| cpr | int(11) | Personal identification number |
| email | varchar(100) | Email address |
| class | varchar(10) | Class/grade designation |
| is_blacklisted | tinyint(1) | Flag for blacklisted users |

### 2. user_position

Defines user roles and positions within the system.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| role | varchar(100) | Role name (e.g., Student, Teacher, Admin) |
| comment | varchar(100) | Additional information about the role |

### 3. computer

Tracks laptop inventory and status.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| fabricator | varchar(50) | Manufacturer name (e.g., DELL, HP) |
| model | varchar(50) | Computer model (e.g., Inspiron 9300) |
| mousetype | varchar(20) | Type of mouse (optical, standard, none) |
| status | varchar(20) | Current status (available, loaned, maintenance) |
| wear | varchar(50) | Condition of the equipment |

### 4. reservation

Manages equipment reservations.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| reservation_line_id | int(11) | Foreign key to reservation_line |
| endDate | date | Reservation end date |
| reservationDate | date | Date when reservation was made |
| status | varchar(20) | Reservation status |

### 5. reservation_line

Links reservations to specific users and computers.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| user_id | int(11) | Foreign key to user |
| computer_id | int(11) | Foreign key to computer |

### 6. loan

Records active and historical loans.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| loan_line_id | int(11) | Foreign key to loan_line |
| reservation_id | int(11) | Foreign key to reservation |
| loanDate | date | Date when loan was issued |
| returnedDate | date | Date when equipment was returned |
| expDate | date | Expected return date |
| status | varchar(20) | Loan status (active, returned, overdue) |

### 7. loan_line

Links loans to specific users and computers.

| Column | Type | Description |
|--------|------|-------------|
| id | int(11) | Primary key |
| user_id | int(11) | Foreign key to user |
| computer_id | int(11) | Foreign key to computer |

## Relationships

The database implements the following key relationships:

1. **User to User Position**: One-to-many relationship between user_position and user.
   - A position can be assigned to multiple users
   - Each user has exactly one position

2. **User to Loan/Reservation**: One-to-many relationship between user and loan_line/reservation_line.
   - A user can have multiple loans/reservations
   - Each loan/reservation is associated with one user

3. **Computer to Loan/Reservation**: One-to-many relationship between computer and loan_line/reservation_line.
   - A computer can be in multiple loans/reservations (over time)
   - Each loan_line/reservation_line refers to one computer

4. **Loan to Reservation**: One-to-one relationship between loan and reservation.
   - A loan can be created from a reservation
   - A reservation can be converted to a loan

## Sample Queries

### Finding Available Computers
```sql
SELECT * FROM computer 
WHERE status = 'available' 
ORDER BY fabricator, model;
```

### Listing Active Loans
```sql
SELECT l.*, u.name, u.email, c.fabricator, c.model 
FROM loan l
JOIN loan_line ll ON l.loan_line_id = ll.id
JOIN user u ON ll.user_id = u.id
JOIN computer c ON ll.computer_id = c.id
WHERE l.status = 'active';
```

### Identifying Overdue Loans
```sql
SELECT l.*, u.name, u.email, c.fabricator, c.model 
FROM loan l
JOIN loan_line ll ON l.loan_line_id = ll.id
JOIN user u ON ll.user_id = u.id
JOIN computer c ON ll.computer_id = c.id
WHERE l.expDate < CURDATE() AND l.returnedDate IS NULL;
```

### Checking Blacklisted Users
```sql
SELECT * FROM user 
WHERE is_blacklisted = 1;
```

## Database Diagram

The database schema can be visualized as follows:

```
user_position (1) --- (*) user (*) --- (*) loan_line (*) --- (1) computer
                                    |
                                    |
                                    (*) reservation_line (*) --- (1) computer
                                          |
                            reservation (*) --- (*) loan
```

## Indexing Strategy

The following indexes are recommended for optimal performance:

1. Primary keys on all tables
2. Foreign key indexes on all relationship columns
3. Index on computer.status for quick availability checks
4. Index on loan.expDate for efficient overdue loan queries
5. Index on user.is_blacklisted for blacklist filtering

## Backup Procedures

Regular database backups should be performed using:

```bash
mysqldump -u [username] -p [database_name] > backup_[date].sql
```

For a complete export with structure and data:

```bash
mysqldump -u [username] -p --databases [database_name] > full_backup_[date].sql
```
