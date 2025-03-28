# UniAPI - CS421 TASK

## Overview
UniAPI is a Laravel-based API designed including programs, students. The API is built with Laravel 12 and deployed on an AWS EC2 instance.

## Features
- ✅ Student Registration
- ✅ Program and Course Handling

---

## Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/uniAPI.git
cd uniAPI

```
### 2. Install Dependencies
```bash
composer install

```

### 3. Environment Configuration
```bash
cp .env.example .env
Then update database settings in .env:
DB_CONNECTION=sqlite
DB_DATABASE=/home/ubuntu/apps/uniAPI/database/database.sqlite

```

### 4. Environment Configuration
```bash
php artisan key:generate

```

### 5. Generate Application Key
```bash
php artisan key:generate

```

### 6. Run Migrations & Seeders
```bash
php artisan migrate --seed

```

### 7. Start the Server
```bash
php artisan serve --host=0.0.0.0 --port=9090

```

## Deployment on AWS EC2

### Ensure your instance has:
```bash
- PHP 8.3

- SQLite3

- Apache/Nginx

- Laravel dependencies

```

## Contribution

```bash
- Fork the repository

- Create a new branch

- Commit your changes

- Push to your fork

- Open a pull request


```

# API Endpoints

| Method      | Url           | Description                                                                       |
|-------------|---------------|-----------------------------------------------------------------------------------|
| GET         | /api/students | [List all students](http://13.60.14.29:9090/api/students)                         |
| GET         | /api/subjects | [List all subjects](http://13.60.14.29:9090/api/students) |


``````

