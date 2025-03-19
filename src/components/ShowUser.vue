<template>
    <div>
      <h1>User List</h1>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Position ID</th>
            <th>Name</th>
            <th>Address</th>
            <th>ZIP</th>
            <th>City</th>
            <th>CPR</th>
            <th>Email</th>
            <th>Class</th>
            <th>Blacklisted</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.id }}</td>
            <td>{{ user.position_id }}</td>
            <td>{{ user.name }}</td>
            <td>{{ user.address }}</td>
            <td>{{ user.zip }}</td>
            <td>{{ user.city }}</td>
            <td>{{ user.cpr }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.class }}</td>
            <td>{{ user.is_blacklisted === '1' || user.is_blacklisted === 1 ? 'Yes' : 'No' }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        users: []
      };
    },
    created() {
      this.fetchUsers();
    },
    methods: {
      async fetchUsers() {
        try {
          const response = await fetch('http://localhost/udlaanregistering-prototype/backend/show_user.php'); 
          this.users = await response.json();
        } catch (error) {
          console.error('Error fetching users:', error);
        }
      }
    }
  };
  </script>
  
  <style scoped>
  </style>
  