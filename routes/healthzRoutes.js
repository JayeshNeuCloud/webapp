const express = require("express");
const asyncHandler = require("express-async-handler");
const db = require("../models");

const router = express.Router();

router.get('/', asyncHandler(async (req, res) => {
    try {
        await db.sequelize.authenticate(); // Attempt to connect to the database
        res.status(200).set('Cache-Control', 'no-cache, no-store, must-revalidate').send('Database connection successful');
    } catch (error) {
        console.error('Database connection error:', error);
        res.status(503).send('Service Unavailable');
    }
}));


// Error handling middleware
router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(503).set('Cache-Control', 'no-cache, no-store, must-revalidate').send('Database connection failed');
});

module.exports = router;
