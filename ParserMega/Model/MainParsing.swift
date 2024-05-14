import UIKit
import WebKit
import SwiftSoup // Для парсинга HTML

var arrayOfPrices : [Int] = []
var arrayOfBonus : [Int] = []
var currentArr : Int = 0
var counter = 0

class ViewController: UIViewController, WKNavigationDelegate {
    
    var onClose: (() -> Void)?
    var nilContent: (() -> Void)?
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //если несколько запросов подряд делать, все равно блочит
        let randomDelay = Double.random(in: 1...3)
        Thread.sleep(forTimeInterval: randomDelay)

        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
     //   view.addSubview(webView)
        
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//               webView.topAnchor.constraint(equalTo: view.topAnchor),
//               webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//               webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//               webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//           ])

        if let url = URL(string: startURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        print(arrayOfPrices)
        print(arrayOfBonus)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { [weak self] (html: Any?, error: Error?) in
            guard let htmlString = html as? String, error == nil else {
                print("Failed to retrieve HTML: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                
                let doc: Document = try SwiftSoup.parse(htmlString)
                let catalog: Elements = try doc.select("div.catalog-items-list")
                let item: Elements = try catalog.select("div[data-list-id=main]")
                for divs in item{
                    
                    //text
                    let itemPiceDivs: Elements = try divs.select("div.item-price")
                    let itemBonusDivs: Elements = try divs.select("div.item-bonus")
                    let itemTitle: Elements = try divs.select("div.item-title")
                    
                    //link
                    let link: Elements = try divs.select("a")
                    let formattedLink : String = try link.attr("href")
                    
                    //image
                    let imageDiv : Elements = try divs.select("div.catalog-item-photo")
                    let image: Elements = try imageDiv.select("img")
                    let imageLink = try image.attr("src")
                    
                    
                    //if нужен для того, что-бы исключить товары не в наличии
                    if Int(try itemPiceDivs.text().filter {$0.isNumber}) ?? -1 != -1 {
                        arrayOfInfoProducts.append(infoAboutProducts(
                            price: Int(try itemPiceDivs.text().filter {$0.isNumber}) ?? -1,
                            bonus: Int(try itemBonusDivs.text().filter {$0.isNumber}) ?? -1,
                            procent: 0,
                            image: imageLink, title: try itemTitle.text(),
                            link: mainURL + "\(formattedLink)"
                        ))
                    }
                }
            } catch {
                print("Failed to parse HTML: \(error.localizedDescription)")
            }
        }
        print(arrayOfInfoProducts)
        if arrayOfInfoProducts.count == currentArr {
            print("No content")
            counter += 1
            if counter > 1 {
                self.dismiss(animated: false)
                self.nilContent?()
            }
            else {
                self.dismiss(animated: false)
                self.onClose?()
            }
        } else {
            self.dismiss(animated: false)
            self.onClose?()
        }
    }
    
}
