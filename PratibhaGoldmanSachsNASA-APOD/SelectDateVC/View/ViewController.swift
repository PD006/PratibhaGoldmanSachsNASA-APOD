//
//  ViewController.swift
//  PratibhaGoldmanSachsNASA-APOD
//
//  Created by Pratibha Dadhich on 26/02/22.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var calendarView: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
   
    @IBAction func favButtonTapped(_ sender: UIButton) {
        guard let favListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.shared.FAVORITE_LIST_VC_IDENTIFIER) as? FavoriteListViewController else { return }
        self.navigationController?.pushViewController(favListViewController, animated: true)
    }
    
    @IBAction func showPictureTapped(_ sender: UIButton) {
        guard let showDetailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constant.shared.SHOW_DETAILS_VC_IDENTIFIER) as? ShowDetailsViewController else { return }
        self.navigationController?.pushViewController(showDetailsViewController, animated: true)
    }
}

//MARK: - FSCalendar Delegate method

extension ViewController : FSCalendarDataSource, FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        CommonConfigs.shared.selctedDate = Date().today(date: date)
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
}
