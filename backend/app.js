const express = require('express');
const router = require('./routes/router')
const app = express();

app.use(express.json());
app.use(express.urlencoded({extended:true}));
app.use(router);


var server = app.listen(5000,()=>{
    console.log('the server created');
})


