const ProductController = require('../controller/product_controller');
const UserController = require('../controller/user.controller');
const router = require('express').Router();

router.get(process.env.ALLPRODUCTS, ProductController.allProducts);
router.post(process.env.REGISTER, UserController.registerUser);
router.post(process.env.LOGIN, UserController.loginUser);
router.get(process.env.INFO, UserController.userInfo);
module.exports = router;