const mysql = require('mysql2');
require('dotenv').config();
var db = mysql.createConnection({
    "host":process.env.HOST,
    "database": process.env.DATABASE,
    "user":process.env.USER,
    "password":process.env.PASSWORD,
    "port": process.env.PORT
});

if (db.connect) {
    console.log('database connected!');
} else {
    console.log('database connection failed!');
}

module.exports = db;
