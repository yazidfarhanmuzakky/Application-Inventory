const AddBarangService = require('../service/addbarang.service');

exports.createAddBarang =  async (req, res, next) => {
    try {
        const { userId, name, quantity, price, barcode } = req.body;
        let addbarangData = await AddBarangService.createAddBarang(userId, name, quantity, price, barcode);
        res.json({ status: true, success: addbarangData });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.getAddBarangList = async (req, res, next) => {
    try {
        const { userId } = req.body;
        let addbarangData = await AddBarangService.getUserAddBarangList(userId);
        res.json({ status: true, success: addbarangData });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.deleteAddBarang = async (req, res, next) => {
    try {
        const { id } = req.body;
        let deletedData = await AddBarangService.deleteAddBarang(id);
        res.json({ status: true, success: deletedData });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

exports.updateAddBarang = async (req, res, next) => {
  try {
    const { userId } = req.body;
    const { name, quantity, price, barcode } = req.body;
    
    // Perform the update operation using the provided data
    let updatedAddBarang = await AddBarangService.updateAddBarang(userId, name, quantity, price, barcode);
    
    // Return the updated add barang item as the response
    res.json({ status: true, success: updatedAddBarang });
  } catch (error) {
    console.log(error, 'err---->');
    next(error);
  }
}
