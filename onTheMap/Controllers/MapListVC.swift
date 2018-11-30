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
    let studentLocParams = StudentLocParams(limit:100,skip:0,order:"-updatedAt")
    var studentList = [StudentsLocResponse.Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getLocationList()
        

    }
    
    func getLocationList(){
        StudentLoc.getLocationList(params: studentLocParams) { (message,response) in
            guard let response = response else{
                return
            }
            if let results = response.results {
                self.studentList = results
                self.tableView.reloadData()
            }
        }
    }
  
    @IBAction func logout(_ sender: Any) {
        self.logout()
    }
    
    
    @IBAction func addLocation(_ sender: Any) {
    }
    @IBAction func reloadLocations(_ sender: Any) {
        studentList = []
        tableView.reloadData()
        getLocationList()
    }
    
    
    
}


extension MapListVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        
        let student = studentList[indexPath.row]
        cell.textLabel?.text = "\(student.firstName!) \(student.lastName!)"
        cell.detailTextLabel?.text = student.mediaURL
        cell.imageView?.image = UIImage(named: "mapSign")
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let url = studentList[indexPath.row].mediaURL {
            UIApplication.shared.open(URL(string:url)!, options: [:], completionHandler: nil)
        }
        
        
    }
    
    
}
