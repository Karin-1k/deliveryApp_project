const UserModule = require('../model/user.module');
const { genSaltSync, hashSync, compareSync } = require('bcrypt');
const { sign, verify } = require('jsonwebtoken');

class UserController {
   static async registerUser(req, res) {
      const body = req.body;
      const salt = genSaltSync(10);
      body.password = hashSync(body.password, salt)
      await UserModule.registerUser(body).then(result => {
         return res.status(200).json({
            success: 1,
            message: result
         });
      }).catch(err => {
         return res.status(500).json({
            success: 0,
            message: `failed user registration: ${err}`
         })
      });
   }

   // loginUser 
   static async loginUser(req, res) {
      const body = req.body;
      await UserModule.loginUser(body).then(result => {

         if (result.length === 0) {
            return res.status(500).json({
               success: 0,
               message: 'invalid password or email'
            })
         }
         const compare = compareSync(body.password, result[0].password);
         if (compare) {
            result[0].password = undefined;
            const token = sign({ result: result }, process.env.TOKEN, {
               expiresIn: '5h'
            })
            return res.status(200).json({
               success: 1,
               message: 'successfuly logged in',
               token: token
            });
         } else {
            return res.status(500).json({
               success: 0,
               message: 'your password is wrong'
            })
         }
      }).catch(err => {
         console.log(err);
      });
   }

   //get user info 
   static async userInfo(req, res) {
      var token = req.get('authorization');
      let email;

      if (token) {
         token = token.slice(7);
         verify(token, process.env.TOKEN, async (err, decode) => {
            if (err) {
               return res.status(500).json({
                  success: 0,
                  message: `invalid token ${err}`
               });
            } else {

               email = decode['result'][0]['email'];

               await UserModule.userInfo(email).then(result => {
                  return res.status(200).json({
                     success: 1,
                     message: result
                  });
               }).catch(err => {
                  return res.status(500).json({
                     success: 0,
                     message: `failed to get user info: ${err}`
                  });
               });

            }
         });
      } else {
         return res.json({
            success: 0,
            message: 'access denied ,Unautorized user'
         });
      }

   }
}

module.exports = UserController;