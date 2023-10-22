//
//  FoodDetailViewModel.swift
//  Food App
//
//  Created by alihizardere on 17.10.2023.
//

import Foundation

class FoodDetailViewModel {
    
    var frepo = FoodDaoRepository()
    
    func addToCart(yemek_adi:String, yemek_resim_adi:String, yemek_fiyat:String, yemek_siparis_adet:String, kullanici_adi:String){
        frepo.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
}
