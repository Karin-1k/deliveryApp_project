const express = require('express');
const router = require('./routes/router')
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(router);

console.log('shta xoshakan');
console.log(process.env.APPPORT);
 console.log(process.env.HOST); 
 console.log(process.env.DATABASE); 
console.log(process.env.USER);
console.log(process.env.PASSWORD);
console.log(process.env.port);
console.log(process.env.TOKEN);
console.log(process.env.ALLPRODUCTS);
console.log(process.env.REGISTER);
console.log(process.env.LOGIN);
console.log(process.env.INFO);

var server = app.listen(process.env.APPPORT, () => {
    console.log('the server created');
})


