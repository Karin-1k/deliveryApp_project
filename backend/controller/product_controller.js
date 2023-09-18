const productModel = require('../model/product_model');
class ProductController {

    static async allProducts(req, res) {
        var result = await productModel.allProduct();
        res.send(result);
    }
}
module.exports = ProductController;