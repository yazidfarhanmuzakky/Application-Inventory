const { deleteAddBarang } = require("../controller/addbarang.controller");
const AddBarangModel = require("../model/addbarang.model");

class AddBarangService{
    static async createAddBarang(userId,name,quantity,price,barcode){
            const createAddBarang = new AddBarangModel({userId,name,quantity,price,barcode});
            return await createAddBarang.save();
    }

    static async getUserAddBarangList(userId){
        const addbarangList = await AddBarangModel.find({userId})
        return addbarangList;
    }

   static async deleteAddBarang(id){
        const deleted = await AddBarangModel.findByIdAndDelete({_id:id})
        return deleted;
   }

   static async updateAddBarang(userId, name, quantity, price, barcode) {
    const updated = await AddBarangModel.findOneAndUpdate(
      { _id: userId },
      { name, quantity, price, barcode },
      { new: true }
    );
    return updated;
  }
}

module.exports = AddBarangService;