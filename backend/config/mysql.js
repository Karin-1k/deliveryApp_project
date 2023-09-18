const mysql = require('mysql2');

var db = mysql.createConnection({
    "host": "localhost",
    "database": "delivery_food",
    "user": "root",
    "password": "",
    "port":"3306"
});

if (db.connect) {
    console.log('database connected!');
} else {
    console.log('database connection failed!');
}

module.exports = db;