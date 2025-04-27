const express = require('express');
const mongoose = require('mongoose');


const port = process.env.PORT;
const app = express();

app.get('/api/notebooks', (req, res) => {
  res.json({
    message: 'Hello from the Notebooks API!',
  });
});

// Connect to MongoDB first, THEN start the server
console.log('Connecting to the DB...');
mongoose.connect(`mongodb://${process.env.NOTEBOOKS_DB_HOST}/${process.env.NOTEBOOKS_DB_NAME}`, {
    auth: {
        username: process.env.NOTEBOOKS_DB_USER,
        password: process.env.NOTEBOOKS_DB_PASSWORD,
    },
    connectTimeoutMS: 500,
})
.then(() => {
    console.log('Connected to MongoDB!');

    // Start the server once DB connection is successful
    app.listen(port, () => {
      console.log(`Notebooks Server listening on port ${port}`);
    });
  })
  .catch((err) => {
    console.error('Error connecting to MongoDB!');
    console.error(err);
    process.exit(1); // Exit container if DB connection fails
  });
