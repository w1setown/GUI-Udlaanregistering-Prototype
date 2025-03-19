<template>
    <div>
        <h2>Add User</h2>
        <form @submit.prevent="addUser">
            <div>
                <label for="name">Name:</label>
                <input type="text" v-model="user.name" required />
            </div>
            <div>
                <label for="address">Address:</label>
                <input type="text" v-model="user.address" required />
            </div>
            <div>
                <label for="zip">Zip Code:</label>
                <input type="number" v-model="user.zip" required />
            </div>
            <div>
                <label for="city">City:</label>
                <input type="text" v-model="user.city" required />
            </div>
            <div>
                <label for="cpr">CPR:</label>
                <input type="text" v-model="user.cpr" required />
            </div>
            <div>
                <label for="class">Class:</label>
                <input type="text" v-model="user.class" required />
            </div>
            <div>
                <label for="email">Email:</label>
                <input type="email" v-model="user.email" required />
            </div>
            <div>
                <label for="position">Position:</label>
                <select v-model="user.position_id" required>
                    <option v-for="position in positions" :key="position.id" :value="position.id">
                        {{ position.role }}
                    </option>
                </select>
            </div>
            <button type="submit">Add User</button>
        </form>
        <p v-if="message">{{ message }}</p>
    </div>
</template>

<script>
import axios from 'axios';

export default {
    name: 'AddUser',
    data() {
        return {
            user: {
                name: '',
                address: '',
                zip: '',
                city: '',
                email: '',
                cpr: '',
                class: '',
                position_id: null 
            },
            positions: [], 
            message: ''
        };
    },
    created() {
        this.fetchPositions();
    },
    methods: {
        async fetchPositions() {
            try {
                const response = await axios.get('http://localhost/udlaanregistering-prototype/backend/get_position.php'); 
                this.positions = response.data;
                console.log('Positions loaded:', this.positions);
            } catch (error) {
                console.error('Error fetching positions:', error);
            }
        },
        async addUser() {
            try {
                const response = await axios.post('http://localhost/udlaanregistering-prototype/backend/add_user.php', this.user);

                if (response.status === 200) {
                    this.message = 'User added successfully!';
                    this.resetForm();
                } else {
                    this.message = 'Failed to add user.';
                }
            } catch (error) {
                console.error('Error:', error);
                this.message = 'An error occurred.';
            }
        },
        resetForm() {
            this.user = {
                name: '',
                address: '',
                zip: '',
                city: '',
                email: '',
                cpr: '',
                class: '',
                position_id: null 
            };
        }
    }
};
</script>

<style scoped>
</style>
