# UniAPI - CS421 TASK

## Overview
UniAPI is a Laravel-based API designed to manage programs and students. The API is built with Laravel 12 and deployed on an AWS EC2 instance.

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

### 3. Configure Environment
```bash
cp .env.example .env
```
Update database settings in `.env`:
```ini
DB_CONNECTION=sqlite
DB_DATABASE=/home/ubuntu/apps/uniAPI/database/database.sqlite
```

### 4. Generate Application Key
```bash
php artisan key:generate
```

### 5. Run Migrations & Seeders
```bash
php artisan migrate --seed
```

### 6. Start the Server
```bash
php artisan serve --host=0.0.0.0 --port=9090
```

## Deployment on AWS EC2

### Ensure your instance has:
- PHP 8.3
- SQLite3
- Apache/Nginx
- Laravel dependencies

## Contribution
1. Fork the repository
2. Create a new branch
3. Commit your changes
4. Push to your fork
5. Open a pull request

## Expected JSON Responses

### Students:
```json
{
    "success": true,
    "count": 10,
    "data": [
        {
            "name": "John Doe",
            "program": "Software Engineering"
        }
    ]
}
```

### Subjects:
```json
{
    "success": true,
    "program": "Software Engineering",
    "data": {
        "Year 1": [
            {
                "id": 1,
                "name": "Principles of Programming Languages"
            }
        ],
        "Year 2": [...],
        "Year 3": [...],
        "Year 4": [...]
    }
}
```

## API Endpoints

| Method | URL            | Description |
|--------|--------------|-------------|
| GET    | `/api/students` | [List all students](http://13.60.14.29:9090/api/students) |
| GET    | `/api/subjects` | [List all subjects](http://13.60.14.29:9090/api/subjects) |
