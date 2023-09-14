const db = require('../config/db');
const UserModel = require("./user.model");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const addbarangSchema = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    name: {
        type: String,
        required: true
    },
    quantity: {
        type: Number,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    barcode: {
        type: Number,
        required: true
    },
},{timestamps:true});

const AddBarangModel = db.model('addbarang',addbarangSchema);
module.exports = AddBarangModel;