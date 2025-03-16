const express = require('express');
const bodyparser = require('body-parser');
const res = require('express/lib/response');

const app = express();
const port = 3000;
const users = [];

app.use(bodyparser.json());

app.get('/', (req, res) => {
    res.send('Hello World');
})

// Get registered users
app.get('/users', (req, res) => {
    return res.json({ users });
})

// Register new user
app.post('/users', (req, res) => {
    const newUserId = req.body.userId;
    if (!newUserId) {
        res.status(400).send('User ID is required');
    }
    if (users.includes(newUserId)) {
        res.status(400).send('User ID already exists');
    }
    users.push(newUserId);
    return res.status(201).send('User created successfully');
})

app.listen(port, () => {
    console.log(`Server is listening on port ${port}`);
});