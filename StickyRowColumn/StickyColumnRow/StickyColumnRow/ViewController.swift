//
//  ViewController.swift
//  StickyColumnRow
//
//  Created by Admin on 28/12/22.
//

import UIKit

class ViewController: UIViewController {
    
    var section0 = ["Jan", "Feb", "March", "April", "MAy", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"]
    
    var section1 = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    var section2 = ["+", "+jjkkjkjjjkjjkjkkjk", "+", "+", "+", "+", "+", "+", "+", "+", "+", "+"]
    var section3 = ["-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-", "-"]
    
    

    var ListOfData:[[String]] = [];
    

    

    @IBOutlet weak var gridCollectionView: UICollectionView! {
        didSet {
            gridCollectionView.bounces = false
        }
    }
    
    @IBOutlet weak var gridLayout: CollectionViewStickyColumnRow! {
        didSet {
            gridLayout.stickyRowsCount = 1
            gridLayout.stickyColumnsCount = 1
        }
    }
    
    override func viewDidLoad() {
        ListOfData.append(section1)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section2)
        ListOfData.append(section3)
        ListOfData.append(section3)
        ListOfData.append(section3)
        ListOfData.append(section3)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }

    override var shouldAutorotate: Bool {
        return true
    }

    
}

// MARK: - Collection view data source and delegate methods

extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ListOfData.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return section0.count
        } else {
            return ListOfData[section - 1].count
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseID, for: indexPath) as! CollectionViewCell

        
        if indexPath.section == 0 {
            cell.titleLabel.text = "\(section0[indexPath.row])"
        } else {
            cell.titleLabel.text = "\(ListOfData[indexPath.section - 1][indexPath.row])"
        }
        
        
        // cell.titleLabel.text = "\(indexPath)"
        
        print(indexPath)
        
        print(gridLayout.isItemSticky(at: indexPath))
        
        cell.backgroundColor = gridLayout.isItemSticky(at: indexPath) ? .groupTableViewBackground : .white

        cell.layer.addBorder(edge: .bottom, color: .lightGray, thickness: 1)

        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
   }
    
    
   
    
}



extension CALayer {

func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

    let border = CALayer()

    switch edge {
    case .top:
        border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
    case .bottom:
        border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
    case .left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
    case .right:
        border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
    default:
        break
    }
    border.backgroundColor = color.cgColor
    addSublayer(border)
    }
}
