//
//  MyCart.swift
//  Food App
//
//  Created by alihizardere on 13.10.2023.
//

import UIKit
import Alamofire
import Kingfisher
import RxSwift
import Firebase

class MyCart: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelTotalPrice: UILabel!    

    var foods = [FoodMyCart]()
    var viewModel = MyCartViewModel()
    let username = "ali_hizardere"
    var cartId:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        labelTotalPrice.text = "0₺"
        
        _ = viewModel.foods.subscribe(onNext: {list in
            self.foods = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })

        //Navbar
        self.navigationItem.title = "Sepetim"
        
        let appearanceNavBar = UINavigationBarAppearance()
        appearanceNavBar.titleTextAttributes = [.foregroundColor: UIColor.systemOrange, .font: UIFont(name: "Marker Felt", size: 33.0)!]
        
        navigationController?.navigationBar.standardAppearance = appearanceNavBar
        navigationController?.navigationBar.compactAppearance = appearanceNavBar
        navigationController?.navigationBar.scrollEdgeAppearance = appearanceNavBar
        
    }
    func getTotalLabel(){
        var price = 0
        var total = 0
        for food in foods{
            price = Int(food.yemek_fiyat!)! * Int(food.yemek_siparis_adet!)!
            total += price
            labelTotalPrice.text = "\(total)₺"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.bringFoodsInTheBasket(kullanici_adi: username)
    }
    
    @IBAction func confirmCartBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "Sipariş Onay", message: " \(cartId) numaralı siparişiniz onaylanmıştır.", preferredStyle: .alert)
        let okBtn = UIAlertAction(title: "Tamam", style: .default)
        alert.addAction(okBtn)
        self.present(alert, animated: true)
    }
    
}

extension MyCart : UITableViewDelegate, UITableViewDataSource, cellProtocol {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = foods[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCartCell") as! MyCartCell
        
        cell.labelFoodName.text = food.yemek_adi
        cell.labelFoodPrice.text = "\(food.yemek_fiyat!)₺"
        cell.labelFoodNumber.text = "\(food.yemek_siparis_adet!) adet"
        cell.labelFoodTotalPrice.text = "\(Int(food.yemek_fiyat!)! * Int(food.yemek_siparis_adet!)!)₺"
        if let url =  URL(string: "\(food.yemek_resim_adi!)") {
            DispatchQueue.main.async {
                cell.labelFoodImage.kf.setImage(with: url)
            }
        }
        cartId = food.sepet_yemek_id!
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        getTotalLabel()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func deleteFood(indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let alertController = UIAlertController(title: "Silme işlemi", message: "\(food.yemek_adi!) adlı ürünü silmek istiyor musunuz?", preferredStyle: .alert)
        let yesButton = UIAlertAction(title: "Evet", style: .cancel){action in
            self.viewModel.deleteItem(sepet_yemek_id: food.sepet_yemek_id!, kullanici_adi: food.kullanici_adi!)
            self.foods.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.reloadData()
            if self.foods.count == 0 {
                self.labelTotalPrice.text = "0₺"
                let alert = UIAlertController(title: "Sepet Boş", message: "Sepetiniz boş. Sipariş vermek için lütfen ürün ekleyin!", preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "Tamam", style: .cancel)
                alert.addAction(okBtn)
                
                self.present(alert, animated: true)
            }
           
        }
        alertController.addAction(yesButton)
        
        let cancelButton = UIAlertAction(title: "İptal", style: .destructive)
        alertController.addAction(cancelButton)
        
        self.present(alertController, animated: true)
        print("\(food.sepet_yemek_id!) id li \(food.kullanici_adi!) kullanıcı adlı yemek silindi")
    }

}
