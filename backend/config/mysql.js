const mysql = require('mysql2');
require('dotenv').config();
var db = mysql.createConnection({
    "host":"bzqf142wakbeyktl5tf6-mysql.services.clever-cloud.com",
    "database": "bzqf142wakbeyktl5tf6",
    "user":"ufvayocwkmsptg1p",
    "password":"OkgpQ10Q4qj5tLrNgXX0",
    "port":3306
});

if (db.connect) {
    console.log('database connected!');
} else {
    console.log('database connection failed!');
}

module.exports = db;
