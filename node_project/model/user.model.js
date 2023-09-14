const mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const db = require('../config/db');

const {Schema} = mongoose;

const userSchema = new Schema({
    username: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        // @ts-ignore
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
},{timestamps:true});

userSchema.pre('save',async function(){
    try{
        var user = this;
        const salt = await(bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password,salt);

        user.password = hashpass;
    } 
    catch(error){
        throw error;
    }
});

userSchema.methods.comparePassword = async function(userPassword){
    try{
        console.log('----------------no password',this.password);
        const isMatch = await bcrypt.compare(userPassword,this.password);
        return isMatch;
    }   catch (error) {
        throw error;
    }
}

const UserModel = db.model('user', userSchema);
module.exports = UserModel;