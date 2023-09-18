const ProductController = require('../controller/product_controller');
const router = require('express').Router();

router.get('/allProduct',ProductController.allProducts);

module.exports = router;