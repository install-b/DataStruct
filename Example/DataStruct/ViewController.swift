//
//  ViewController.swift
//  DataStruct
//
//  Created by 645256685@qq.com on 07/15/2020.
//  Copyright (c) 2020 645256685@qq.com. All rights reserved.
//

import UIKit
import DataStruct

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLinkList()
        
        testDoublyLinkList()
    }
    
    func testLinkList() {
        var linkList = SingleLinkList(contentsOf: 1...9)
        print(linkList.debugDescription)
        linkList.removeLast()
        print(linkList.debugDescription)
        linkList.removeFirst()
        print(linkList.debugDescription)
        linkList.insert(44, at: 3)
        print(linkList.debugDescription)
        linkList.append(33)
        print(linkList.debugDescription)
        linkList.append(contentsOf: 100..<109)
        print(linkList.debugDescription)
        linkList.remove(at: 17)
        print(linkList.debugDescription)
        linkList.remove(at: 1)
        print(linkList.debugDescription)
        linkList.insert(10086, after: 107)
        print(linkList.debugDescription)
        linkList.insert(10010, before: 2)
        print(linkList.debugDescription)
        linkList.insert(10009, before: 44)
        print(linkList.debugDescription)
        print(linkList[17])
        linkList[17] = 17
        print(linkList.debugDescription)
        print(linkList.contains(4))
        print(linkList.contains(20))
        linkList.reverse()
        print(linkList.debugDescription)
    }
    
    
    func testDoublyLinkList() {
        var linkList = DoublyLinkList(contentsOf: 1...9)
        print(linkList.debugDescription)
        linkList.removeLast()
        print(linkList.debugDescription)
        linkList.removeFirst()
        print(linkList.debugDescription)
        linkList.insert(44, at: 3)
        print(linkList.debugDescription)
        linkList.append(33)
        print(linkList.debugDescription)
        linkList.append(contentsOf: 100..<109)
        print(linkList.debugDescription)
        linkList.remove(at: 17)
        print(linkList.debugDescription)
        linkList.remove(at: 1)
        print(linkList.debugDescription)
        linkList.insert(10086, after: 107)
        print(linkList.debugDescription)
        linkList.insert(10010, before: 2)
        print(linkList.debugDescription)
        linkList.insert(10009, before: 44)
        print(linkList.debugDescription)
        print(linkList[17])
        linkList[17] = 17
        print(linkList.debugDescription)
        print(linkList.contains(4))
        print(linkList.contains(20))
        linkList.reverse()
        print(linkList.debugDescription)
    }
}

