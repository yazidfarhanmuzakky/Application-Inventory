const app = require('./app');
const db = require('./config/db');
const UserModel = require('./model/user.model');
const AddBarangModel = require('./model/addbarang.model');

const port = 1111;

app.get('/',(req,res)=>{
    res.send("Hello Word!!!!.....")
})

app.listen(port, ()=> {
    console.log('server Listening on Port http://localhost:${port}');
});