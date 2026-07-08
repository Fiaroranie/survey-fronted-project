# Deployment Guide

This project has two deployable parts:

```text
Browser
  -> Vue frontend
  -> Express API
  -> PostgreSQL database
```

## Option A: Frontend Only

Use this when you only need other people to view the web page.

1. Build the frontend:

```bash
npm run build
```

2. Deploy the `dist/` folder to a static host such as Vercel, Netlify, GitHub Pages, Nginx, or a school server.

Important: survey submission will not work unless the Express API and PostgreSQL database are also deployed.

## Option B: Full Deployment

Use this when other people should fill in and submit surveys.

You need:

- A static frontend host
- A Node.js host for `server.js`
- A PostgreSQL database reachable from the API host

## Frontend Settings

Set this environment variable in the frontend hosting platform:

```env
VITE_API_BASE_URL=https://your-api.example.com
```

Then build:

```bash
npm install
npm run build
```

Deploy command:

```bash
npm run build
```

Publish/output directory:

```text
dist
```

## Backend Settings

Set these environment variables in the backend hosting platform:

```env
PORT=3000
CORS_ORIGIN=https://your-frontend.example.com
PGHOST=your-postgres-host
PGPORT=5432
PGUSER=your-postgres-user
PGPASSWORD=your-postgres-password
PGDATABASE=Asian_elephant
```

Install command:

```bash
npm install
```

Start command:

```bash
npm start
```

Health check:

```text
https://your-api.example.com/api/health
```

## CORS

`CORS_ORIGIN` protects the API from random browser origins. For one frontend URL:

```env
CORS_ORIGIN=https://your-frontend.example.com
```

For multiple frontend URLs, use commas:

```env
CORS_ORIGIN=https://your-frontend.example.com,http://localhost:5173
```

If `CORS_ORIGIN` is empty, the API allows browser requests from any origin. That is convenient locally, but not recommended for production.

## Local Network Demo

For a temporary same-Wi-Fi demo:

```bash
npm run server
npm run dev -- --host 0.0.0.0
```

Other people on the same network can open:

```text
http://your-computer-ip:5173
```

For this mode, set the frontend API URL to your computer IP:

```env
VITE_API_BASE_URL=http://your-computer-ip:3000
```

## Final Checklist

- The database schema exists.
- PostGIS is enabled if `gps_coordinates` uses geometry.
- Backend `/api/health` returns `success: true`.
- Frontend `VITE_API_BASE_URL` points to the deployed backend URL.
- Backend `CORS_ORIGIN` includes the deployed frontend URL.
- `.env` files and real passwords are not committed.
