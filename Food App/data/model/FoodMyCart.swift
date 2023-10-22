//
//  AddFoodToCart.swift
//  Food App
//
//  Created by alihizardere on 12.10.2023.
//

import Foundation

class FoodMyCart :  Codable {
    var sepet_yemek_id:String?
    var kullanici_adi:String?
    var yemek_id:String?
    var yemek_adi:String?
    var yemek_resim_adi:String?
    var yemek_fiyat:String?
    var yemek_siparis_adet:String?
    
    init(sepet_yemek_id: String, kullanici_adi: String, yemek_id: String, yemek_adi: String, yemek_siparis_adet:String, yemek_resim_adi: String, yemek_fiyat: String) {
        self.sepet_yemek_id = sepet_yemek_id
        self.kullanici_adi = kullanici_adi
        self.yemek_id = yemek_id
        self.yemek_adi = yemek_adi
        self.yemek_resim_adi = yemek_resim_adi
        self.yemek_fiyat = yemek_fiyat
        self.yemek_siparis_adet = yemek_siparis_adet
    }
    
    
}