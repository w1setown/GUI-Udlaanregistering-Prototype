import { createRouter, createWebHistory } from 'vue-router';
import Home from './components/AppHome.vue'; // Import your components

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home // Use the imported component
  },
  // Add more routes here as needed
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
