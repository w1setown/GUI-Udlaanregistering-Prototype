<template>
  <div>
    <h1>Welcome to the Home Page</h1>
    <nav>
      <router-link to="/">Add User</router-link>
      <router-link to="/User">Show Users</router-link>
    </nav>
    <!-- Other content -->
  </div>
</template>

<script>
export default {
  name: 'AppHeader'
};
</script>

<style scoped>
/* Your styles here */
nav {
  margin: 20px 0;
}
nav a {
  margin: 0 10px;
  text-decoration: none;
  color: #42b983;
}
</style>
