const db = require('../config/mysql');
class UserModule {
    static async registerUser(body) {
        return new Promise((resolve, reject) => {
            const { name, phone, email, password } = body;
            let sql = 'insert into users(name,phone,email,password,status,email_verified,remember_token,created_at,updated_at,order_count) values (?,?,?,?,?,?,?,now(),now(),?)';
            db.query(sql, [name, phone, email, password, 1, 'NO', 'null', 0], (err, result) => {
                if (err) {
                    console.log('there is an err in registerUser from user module file: ', err);
                    return reject(err);
                } else {
                    return resolve(result);
                }
            });
        });
    }
    // login user 
    static async loginUser(body) {
        return new Promise((resolve, reject) => {
            const { email } = body;
            let sql = 'select * from users where email = ?';
            db.query(sql, [email], (err, result) => {
                if (err) {
                    console.log('ther is an err in login user from user module: ', err);
                    return reject(err);
                } else {
                    return resolve(result);
                }
            });

        });
    }
    // get user info 
    static async userInfo(email) {
        return new Promise((resolve, reject) => {
            let sql = 'select * from users where email=?';

            db.query(sql, [email], (err, result) => {
                if (err) {
                    console.log('there is an err in user model: ', err);
                    return reject(err);
                } else {
                    return resolve(result);
                }
            });
        });
    }
}

module.exports = UserModule;