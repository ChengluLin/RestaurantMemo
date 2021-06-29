//
//  RestaurantTableViewController.swift
//  RestaurantMemo
//
//  Created by ChengLu on 2021/6/28.
//



import UIKit
import GDataXML_HTML

let queue = OperationQueue()
var doc: GDataXMLDocument?
var restaurants: [GDataXMLElement] = []

class RestaurantTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://gis.taiwan.net.tw/XMLReleaseALL_public/restaurant_C_f.xml"){
            let request = URLRequest(url: url)
            let session = URLSession.shared
            
            let tesk = session.dataTask(with: request) { data, response, error in
                if let e = error {
                    print("error\(e)")
                    return
                }
                guard let responseData = data else {
                    return
                }
                do{
                    doc = try GDataXMLDocument(data: responseData)
                    let XMLHead = doc?.rootElement()
                    if let infos = XMLHead?.elements(forName: "Infos").first as? GDataXMLElement {
                        if let info = infos.elements(forName: "Info") as? [GDataXMLElement] {
                            restaurants = info
                            let firstRestaurant = restaurants[0]
                            if let nameElement = firstRestaurant.elements(forName: "Name").first as? GDataXMLElement,
                               let restaurantName = nameElement.stringValue() {
                                print(restaurantName)
                            }
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                    
                } catch {
                    print("error\(error)")
                }
            }
            tesk.resume()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RestaurantTableViewCell
        
        let s = restaurants[indexPath.row]
        if let nameElement = s.elements(forName: "Name").first as? GDataXMLElement,
           let stationName = nameElement.stringValue() {
            cell.cellName.text = stationName
        }
        if let nameElement = s.elements(forName: "Add").first as? GDataXMLElement,
           let stationName = nameElement.stringValue() {
            cell.cellAdd.text = stationName
        }
        if let telElement = s.elements(forName: "Tel").first as? GDataXMLElement,
           let telephone = telElement.stringValue() {
            cell.cellnumber.text = telephone
        }
        if let imageElement = s.elements(forName: "Picture1").first as? GDataXMLElement,
           let imageDatas = imageElement.stringValue() {
            print(imageDatas)
            if let url = URL(string: imageDatas) {
                if let imageData = try? Data(contentsOf: url) {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.cellImage.image = image
                        
                    }
                }
            }
        }
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
