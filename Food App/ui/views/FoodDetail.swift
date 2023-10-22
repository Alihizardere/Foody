//
//  FoodDetail.swift
//  Food App
//
//  Created by alihizardere on 12.10.2023.
//

import UIKit
import Alamofire
import Kingfisher

class FoodDetail: UIViewController {
    
    @IBOutlet weak var labelFoodName: UILabel!
    @IBOutlet weak var labelFoodImage: UIImageView!
    @IBOutlet weak var labelFoodPrice: UILabel!
    @IBOutlet weak var foodNumber: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
   
    var food:Foods?
    var viewModel = FoodDetailViewModel()
    var foodImageName:String?
    let imageBaseURL = "http://kasimadalan.pe.hu/yemekler/resimler/"
    let username = "ali_hizardere"
    var foodCount = 1
    var price = 1
    var total = 1
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        foodNumber.text = String(foodCount)
        
        self.navigationItem.hidesBackButton = true
        
        if let f = food{
            foodImageName = "\(imageBaseURL)\(f.yemek_resim_adi!)"
            labelFoodName.text = f.yemek_adi
            labelFoodPrice.text = "\(f.yemek_fiyat!)"
            if let url = URL(string: "\(imageBaseURL)\(f.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.labelFoodImage.kf.setImage(with: url)
                }
            }
        }
        calculateTotalPrice()
    }
    
    @IBAction func buttonIncrease(_ sender: Any) {
            foodCount += 1
            foodNumber.text = String(foodCount)
            calculateTotalPrice()
    }
    
    @IBAction func buttonDecrease(_ sender: Any) {
        if foodCount <= 1 {
            foodNumber.text = "1"
        }else{
            foodCount -= 1
            foodNumber.text = String(foodCount)
        }
            calculateTotalPrice()
    }
    
    func calculateTotalPrice() {
        if let f  = food {
            price = Int(f.yemek_fiyat!)!
            total = foodCount * price
            labelTotalPrice.text = "\(total)₺"
        }
    }
    
    @IBAction func buttonAddToCart(_ sender: Any) {
        if let yemek_adi = labelFoodName.text, let yemek_resim_adi = foodImageName,let yemek_fiyat = labelFoodPrice.text ,let yemek_siparis_adet = foodNumber.text{
            viewModel.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: String(Int(yemek_fiyat)!), yemek_siparis_adet: String(Int(yemek_siparis_adet)!), kullanici_adi: username)
           
            let alertController = UIAlertController(title: "Sepete Ekleme", message: "Sepete \(yemek_siparis_adet) adet \(yemek_adi) eklendi.", preferredStyle: .alert)
            let OKButton = UIAlertAction(title: "Tamam", style: .destructive)
            alertController.addAction(OKButton)
            
            self.present(alertController, animated: true)
            
        }
    }
}
