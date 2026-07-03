# MACS MF – Microfinance Management System

A full-stack web application for microfinance management built with:
- **Frontend**: HTML5 + Vanilla CSS (existing structure preserved)
- **Backend**: Python 3 + Flask
- **Database**: MongoDB

---

## Quick Start

### 1. Install MongoDB (macOS)
```bash
brew tap mongodb/brew
brew trust mongodb/brew
brew install mongodb-community
brew services start mongodb-community
```

### 2. Install Python Dependencies
```bash
cd backend
pip3 install -r requirements.txt --break-system-packages
```

### 3. Seed the Database
```bash
cd backend
python3 seed.py
```
This creates:
- Admin user: **asindu / 1234** (password stored as bcrypt hash)
- Branch: ANAMADUWA, COLOMBO, KANDY, GALLE
- Empty collections: loans, clients, cbos, payments, settlements

### 4. Start the Server
```bash
cd backend
python3 app.py
```
Server runs on **http://localhost:5001**

### 5. Open the App
Open `loginpage.html` in your browser, or use a local file server.

---

## OR: Use the Start Script
```bash
./start.sh
```
This does all of steps 1-4 automatically.

---

## Project Structure
```
lesh/
├── loginpage.html        ← Login page
├── loginpage.css         ← Login styles
├── dashboard.html        ← Main dashboard (all pages)
├── dashboard.css         ← Dashboard styles
├── start.sh              ← One-command startup script
│
└── backend/
    ├── app.py            ← Flask application entry point
    ├── auth.py           ← bcrypt + JWT helpers
    ├── db.py             ← MongoDB connection
    ├── seed.py           ← Database seeder
    ├── requirements.txt  ← Python dependencies
    ├── .env              ← Environment variables (port, DB, JWT secret)
    ├── models/
    │   ├── users.py
    │   ├── loans.py
    │   ├── clients.py
    │   ├── branches.py
    │   ├── cbos.py
    │   └── payments.py
    └── routes/
        ├── auth_routes.py     ← POST /api/login, /api/logout
        ├── loan_routes.py     ← GET/POST /api/loans
        ├── cashier_routes.py  ← GET /api/disburse-loans, /api/group-payments
        ├── client_routes.py   ← GET/POST /api/clients
        └── cbo_routes.py      ← GET /api/branches, /api/cbos, /api/credit-officers
```

---

## API Endpoints

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/api/login` | None | Login, returns JWT token |
| POST | `/api/logout` | JWT | Logout |
| GET | `/api/health` | JWT | Health check |
| GET | `/api/branches` | JWT | List all branches |
| GET | `/api/cbos` | JWT | List CBOs (filter by branch) |
| GET | `/api/credit-officers` | JWT | List credit officers |
| GET | `/api/loans` | JWT | List loans (many filters) |
| GET | `/api/loans/:id` | JWT | Get single loan |
| POST | `/api/loans` | JWT | Create new loan |
| GET | `/api/disburse-loans` | JWT | Loans pending disbursement |
| POST | `/api/disburse-loans/:id/disburse` | JWT | Disburse a loan |
| POST | `/api/disburse-loans/:id/send-back` | JWT | Send loan back |
| GET | `/api/group-payments` | JWT | Group payment sheet |
| GET | `/api/collection` | JWT | Collection data |
| GET | `/api/clients` | JWT | List clients |
| GET | `/api/clients/:id` | JWT | Get single client |
| POST | `/api/clients` | JWT | Create new client |

---

## Security Features
- **bcrypt** password hashing (cost factor 12)
- **JWT** tokens (1-hour expiry, HS256 signed)
- **Rate limiting**: max 5 login attempts per minute per IP
- **Session guard**: dashboard redirects to login if token is missing
- **Token verification** on every protected API endpoint
- **CORS** restricted to localhost origins

---

## Default Login
- **Username**: `asindu`
- **Password**: `1234`

> ⚠️ Change the JWT secret in `backend/.env` before production deployment!
