import { createRouter, createWebHistory } from 'vue-router';
import AddUser from './components/AppAddUser.vue';
import ShowUser from './components/ShowUser.vue';

const routes = [
  {
    path: '/',
    name: 'AddUser',
    component: AddUser 
  },
  {
    path: '/User',
    name: 'ShowUser',
    component: ShowUser 
  },
];

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
});

export default router;
