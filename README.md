# Survey Frontend

Vue 3 + Vite questionnaire application for collecting survey data about Asian elephant distribution and socioeconomic development. The project also includes a small Express API that writes submitted survey records to PostgreSQL.

## Requirements

- Node.js 18 or newer
- npm
- PostgreSQL database with the required survey tables
- PostGIS enabled if `information.gps_coordinates` uses PostGIS geometry

## Install

```bash
npm install
```

## Local Environment

Create a local `.env` file:

```bash
copy .env.example .env
```

Then update the database values:

```env
VITE_API_BASE_URL=http://localhost:3000

PORT=3000
CORS_ORIGIN=http://localhost:5173
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=your-password
PGDATABASE=Asian_elephant
```

Do not commit `.env`.

## Development

Start the backend API:

```bash
npm run server
```

Start the Vite frontend in another terminal:

```bash
npm run dev
```

The API health check is available at:

```text
http://localhost:3000/api/health
```

## Build

```bash
npm run build
```

Preview the production build locally:

```bash
npm run preview
```

## Project Structure

```text
survey-frontend/
|-- .env.example
|-- .env.production.example
|-- index.html
|-- package.json
|-- project-review.html
|-- server.js
|-- vite.config.js
|-- public/
|   |-- favicon.svg
|   |-- icons.svg
|-- src/
|   |-- App.vue
|   |-- main.js
|   |-- style.css
|   |-- api/
|   |   |-- surveyApi.js
|   |-- components/
|   |   |-- survey/
|   |   |-- ui/
|   |       |-- FloatingBubbles.vue
|   |-- data/
|   |   |-- surveyOptions.js
|   |-- utils/
|       |-- createSurveyForm.js
|       |-- validateSurveyForm.js
```

## Deployment

See [DEPLOYMENT.md](./DEPLOYMENT.md).
