//
//  MapListVC.swift
//  onTheMap
//
//  Created by Tawfeeq on 24/11/2018.
//  Copyright © 2018 tam. All rights reserved.
//

import UIKit

class MapListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let studentLocParams = StudentLocParams(limit:100,skip:0,order:"-updatedAt",search:nil)
    //var studentList = [StudentResult]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getLocationList()
    }
    
    func getLocationList(){
        StudentLoc.getLocationList(params: studentLocParams) { (message,response) in
            guard let response = response else{
                self.showAlert(HttpLoginStatus.RESPONSE_ERROR.rawValue)
                return
            }
            if let results = response.results {
                self.appDelegate.studentList = results
                self.tableView.reloadData()
            }
            else {
                self.showAlert(message)
                return
            }
        }
    }
  
    @IBAction func logout(_ sender: Any) {
        self.logout()
    }
    
    @IBAction func reloadLocations(_ sender: Any) {
        appDelegate.studentList = []
        tableView.reloadData()
        getLocationList()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        self.performSegue(withIdentifier: "addLocation", sender: nil)
    }
}


extension MapListVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        
        let student = appDelegate.studentList[indexPath.row]
        cell.textLabel?.text = "\(student.firstName ?? "N/A") \(student.lastName ?? "N/A")"
        cell.detailTextLabel?.text = student.mediaURL
        cell.imageView?.image = UIImage(named: "mapSign")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = appDelegate.studentList[indexPath.row].mediaURL {
            openURL(url: url)
        }
    }
}
