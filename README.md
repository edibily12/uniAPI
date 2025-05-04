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

| Method | URL            | Description                                                 |
|--------|--------------|-------------------------------------------------------------|
| GET    | `/api/students` | [List all students](http://13.60.253.221:9090/api/students) |
| GET    | `/api/subjects` | [List all subjects](http://13.60.253.221:9090/api/subjects) |


# Server Management Scripts

This directory contains automated scripts for managing an AWS EC2 instance running a Laravel application.

## Scripts Overview

### 1. `health_check.sh`
- **Purpose**: Monitors server resources and API health
- **Checks**:
    - CPU/Memory/Disk usage
    - Web server status (Apache/Nginx)
    - API endpoint responsiveness
- **Frequency**: Runs every 6 hours
- **Logs**: `/path/to/log/server_health.log`

### 2. `backup_api.sh`
- **Purpose**: Creates compressed backups of the application and database
- **Backups**:
    - Application files to `/path/to/backups/api_backup_YYYY-MM-DD.tar.gz`
    - MySQL database to `/path/to/backups/db_backup_YYYY-MM-DD.sql`
    - Auto-deletes backups older than 7 days
- **Frequency**: Daily at 2 AM
- **Logs**: `/path/to/log/backup.log`

### 3. `update_server.sh`
- **Purpose**: Automates system and application updates
- **Actions**:
    - Updates Ubuntu packages (`apt update && apt upgrade`)
    - Pulls latest code from GitHub
    - Restarts web services
- **Frequency**: Every 3 days at 3 AM
- **Logs**: `/path/to/log/update.log`

## Setup Instructions

### Prerequisites
Ensure these packages are installed:
```bash
    sudo apt update
    sudo apt install -y curl git mysql-client
```
## Installation
- **Clone this repository:**
```bash
    git clone https://github.com/edibily12/uniAPI.git
```
- **Set execute permissions:**
```bash
    chmod +x bash_scripts/*.sh 
```
- **Deploy scripts to /usr/local/bin/ or keep to home directory:**
```bash
    sudo cp bash_scripts/*.sh /usr/local/bin/ 
```

## Cron Job Configuration
- **Edit crontab:**
```bash
    crontab -e
````
- **Add these lines:**
```bash
    0 */6 * * * /usr/local/bin/health_check.sh
    0 2 * * * /usr/local/bin/backup_api.sh 
    0 3 */3 * * /usr/local/bin/update_server.sh 
```

# UniAPI - Docker Deployment

## System Requirements
- Docker 20.10+
- Docker Compose 2.0+
- 2GB RAM (Minimum)
- AWS EC2 Ubuntu 22.04 (Recommended)

## Deployment Guide

### **1. Build Docker Images**
```bash
docker-compose build
```

### **2. Start Containers in detached mode**
```bash
docker-compose up -d
```

### **3. Application Setup**
```bash
# Run database migrations
docker-compose exec app php artisan migrate:fresh --seed

# Generate application key
docker-compose exec app php artisan key:generate
```

### **4. Access the Application**
- API-students: [List all students](http://13.60.253.221:9090/api/students)
- API-subjects: [List all subjects](http://13.60.253.221:9090/api/subjects)

## Container Management

| Command                      | Description |
|------------------------------|-------------|
| `docker compose ps`          | List running containers |
| `docker compose logs -f app` | View app logs |
| `docker compose restart app` | Restart API container |

## Troubleshooting

### **Common Issues**

1. **Port Conflicts**:
   ```bash
   netstat -tulnp | grep :8000  # Find conflicting processes
   ```

2. **Database Connection Errors**:
   ```bash
   docker-compose exec db mysql -uroot -p
   ```

3. **Permission Issues**:
   ```bash
   docker-compose exec app chown -R www-data:www-data storage
   ```

4. **Out of Memory**:
   ```bash
   docker stats  # Monitor resource usage
   ```

## AWS Configuration Checklist
- [ ] EC2 Instance: t3.micro
- [ ] Security Groups: Ports 22, 80, 443, 8000 open
- [ ] Elastic IP assigned (optional)
- [ ] Daily backups configured

## Docker Images
- API: `edibily12/uniapi-app:latest`
- Nginx: `edibily12/uniapi-nginx:latest`
- MySQL: `edibily12/uniapi-mysql:latest`
