//
//  DataForFind.swift
//  ParserMega
//
//  Created by Владислав Баранов on 02.05.2024.

struct infoAboutProducts {
    var price = Int()
    var bonus = Int()
    var procent = Double()
    var image = String()
    var title = String()
    var link = String()
    var lastPrice = Double()
}

import UIKit

var priceTo = ""
var priceFrom = ""
var listOfPromos: [(Int, Int)] = [] //(размер скидки, от цены)
var findigProduct = ""
var currentPrime = 2
var arrayOfInfoProducts : [infoAboutProducts] = []

var mainURL = "https://megamarket.ru/"
var startURL = "https://megamarket.ru/catalog/page-1/?q="
var currentPage = 0

func configureURL(){
    //replce " " to %20
    var filterArrayInput = findigProduct.split(separator: " ")
    findigProduct = ""
    for i in 0..<filterArrayInput.count{
        findigProduct += filterArrayInput[i]
        if i < filterArrayInput.count - 1 {
            findigProduct += "%20"
        }
    }
    print(findigProduct)
    
    startURL += findigProduct
    
    if priceTo != "" || priceFrom != "" {
        startURL +=  "#?filters=%7B%2288C83F68482F447C9F4E401955196697%22%3A%7B%22"
        if priceFrom != "" {
            startURL += "min%22%3A\(priceFrom)%2C%22"
        }
        if priceTo != "" {
            startURL += "max%22%3A\(priceTo)%7D%7D"
        }
    }
    startURL += "&sort=1"
    print(startURL)
}


func addPage(){
    var urlArray = Array(startURL)
    print(urlArray[35])
        if let digit = Int(String(urlArray[35])) {
            if digit < 9 {
                urlArray[35] = Character(String(digit + 1))
                currentPage = digit + 1
            }
        }
    print(urlArray[35])
    startURL = String(urlArray)
}

func reboot(){
    currentPage = 0
    counter = 0
    arrayOfInfoProducts = []
    mainURL = "https://megamarket.ru/"
    startURL = "https://megamarket.ru/catalog/page-1/?q="
}


func workingWithArrayOfData(){
    var sortedProducts = arrayOfInfoProducts.sorted(by: { $0.price < $1.price })
    for i in 0..<sortedProducts.count{
        
        var maxPromo = 0
        
        
        for j in 0..<listOfPromos.count{
            if listOfPromos[j].1 < sortedProducts[i].price &&  listOfPromos[j].0 > maxPromo {
                maxPromo = listOfPromos[j].0
                print("Max promo = ", maxPromo)
            }
        }
        
        
        if sortedProducts[i].bonus != -1 {
            sortedProducts[i].procent = Double(Double(sortedProducts[i].bonus) / Double(sortedProducts[i].price))
        }
        
        sortedProducts[i].procent = sortedProducts[i].procent + Double(Double(currentPrime) / 100)
        
        sortedProducts[i].lastPrice = Double(Double(sortedProducts[i].price - maxPromo) * Double(1.00 - sortedProducts[i].procent))
        
    }
    arrayOfInfoProducts = sortedProducts.sorted(by: { $0.lastPrice < $1.lastPrice })
}



//test
//var arrayOfInfoProducts : [infoAboutProducts] = [infoAboutProducts.init(price: Int(82174.0), bonus: -1, procent: 0.02, image: "https://main-cdn.sbermegamarket.ru/mid9/hlr-system/182/199/964/751/428/600012705384b0.jpeg", title: "Игровая приставка Sony PlayStation 5 (3-ревизия)+Witcher Wild Hunt 3", link: "https://megamarket.ru//catalog/details/igrovaya-pristavka-sony-playstation-5-3-reviziya-witcher-wild-hunt-3-600012705384_23055/#?related_search=ps 5", lastPrice: 80525.62), infoAboutProducts.init(price: Int(82774.0), bonus: -1, procent: 0.02, image: "https://main-cdn.sbermegamarket.ru/mid9/hlr-system/122/558/998/992/313/37/100060594350b0.png", title: "Игровая приставка Sony PlayStation 5 (3-ревизия)+Atomic", link: "https://megamarket.ru//catalog/details/igrovaya-pristavka-sony-playstation-5-3-reviziya-atomic-100060594350_23055/#?related_search=ps 5", lastPrice: 81113.62), infoAboutProducts.init(price: Int(82774.0), bonus: -1, procent: 0.02, image: "https://main-cdn.sbermegamarket.ru/mid9/hlr-system/-11/086/028/515/101/154/600011897270b0.jpeg", title: "Игровая приставка Sony PlayStation 5 (3-ревизия)+Metro Exodus", link: "https://megamarket.ru//catalog/details/igrovaya-pristavka-sony-playstation-5-3-reviziya-metro-exodus-600011897270_23055/#?related_search=ps 5", lastPrice: 81113.62)]
