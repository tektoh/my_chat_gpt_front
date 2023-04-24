// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: ['@nuxtjs/tailwindcss'],
  css: [
    '~/assets/css/tailwind.css',
  ],
  runtimeConfig: {
    public: {
      API_SERVER_URL: process.env.API_SERVER_URL || "http://localhost:5000",
    }
  }
})
