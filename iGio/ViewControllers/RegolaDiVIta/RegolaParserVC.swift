////
////  RegolaParserVC.swift
////  SFA
////
////  Created by Dani Tox on 25/11/2018.
////  Copyright © 2018 Dani Tox. All rights reserved.
////
//
//import UIKit
//
//class RegolaParserVC: UIViewController, HasCustomView {
//    typealias CustomView = RegolaParserView
//    override func loadView() {
//        super.loadView()
//        view = CustomView()
//    }
//    
////    var tableType : RegolaVitaViewType! = .mainPage
//    var regola : Regola!
////    var selectedCategory : RegolaCategory?
//    
//    var tableView : UITableView { return rootView.tableView }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        guard let _ = tableType else {
//            fatalError("RegolaVC non ha un tableType")
//        }
//        guard let _ = regola else {
//            fatalError("RegolaVC non ha una regola!")
//        }
//    }
//    
//}
//
//extension RegolaParserVC : UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch tableType! {
//        case .mainPage:
//           // if section == 0 { return regola.headers.count }
////            if section == 1 { return regola.categories.count }
//            else { return 0 }
//        case .questionsPage:
//            return selectedCategory?.domande.count ?? 0
//        }
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        switch tableType! {
//        case .mainPage:
//            return 2
//        case .questionsPage:
//            return 1
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if tableType! == .mainPage {
//            if section == 0 {
//                return "Generale"
//            } else {
//                return "Categorie"
//            }
//        } else {
//            return "Riflessioni"
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        if tableType! == .mainPage {
//            if indexPath.section == 0 {
//               // cell.textLabel?.text = regola?.headers[indexPath.row].domanda
//            } else {
//                cell.textLabel?.text = regola?.categories[indexPath.row].name
//            }
//        } else {
//            cell.textLabel?.text = selectedCategory?.domande[indexPath.row].domanda
//        }
//        return cell
//    }
//}
