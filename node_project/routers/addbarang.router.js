const router = require('express').Router();
const AddBarangController = require('../controller/addbarang.controller');

router.post('/createAddBarang',AddBarangController.createAddBarang);

router.get('/getUserAddbarangList',AddBarangController.getAddBarangList);

router.post('/deleteAddBarang',AddBarangController.deleteAddBarang);

router.post('/updateAddBarang',AddBarangController.updateAddBarang);

module.exports = router;