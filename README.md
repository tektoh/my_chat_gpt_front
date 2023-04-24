# Nuxt 3 Minimal Starter

Look at the [Nuxt 3 documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

## Setup

Make sure to install the dependencies:

```bash
npm install
```

## Development Server

Start the development server on `http://localhost:3000`

```bash
npm run dev
```

## Production

Build the application for production:

```bash
npm run build
```

Locally preview production build:

```bash
npm run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.

## Docker
Build image.
```
docker build --build-arg API_SERVER_URL=https://xxxxx-chat-gpt.onrender.com -t my_chat_gpt_front .
```

Run a container.
```
docker run -p 3000:3000 -i -t my_chat_gpt_front
```