const db = require('../config/mysql');
class ProductModel {
// get the products form product table 
    static async allProduct() {

        return new Promise((resolve, reject) => {
            let query = 'select * from products';
            db.query(query, [], (err, result) => {
                if (err) {
                    reject(err);
                    console.log(err);
                    console.log('err in all products in product model');
                } else {
                    resolve(result);
                }
            });
        });
    }
}

module.exports = ProductModel;