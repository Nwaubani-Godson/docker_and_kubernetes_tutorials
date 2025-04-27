const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const port = process.env.PORT;
const app = express();
app.use(bodyParser.json());

app.get('/', (req, res) => {
    return res.json({
        message: 'Welcome to the Key-Value Store API!',
    })
})

app.get('/health', (req, res) => {
    res.status(200).send('up and running, all good!! Enjoy!');
});

console.log('Connecting to the DB...');
mongoose.connect(`mongodb://${process.env.MONGODB_HOST}/${process.env.KEY_VALUE_DB}`, {
    auth: {
        username: process.env.KEY_VALUE_DB_USER,
        password: process.env.KEY_VALUE_DB_PASSWORD,
    },
    connectTimeoutMS: 500,
})
.then(() => {
    app.listen(port, () => {
        console.log(`Server is listening on port ${port}`);
    });
    console.log('Connected to the DB');
})
.catch(err => {
    console.error('Error connecting to MongoDB:', err);
});
