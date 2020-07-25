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
        
//        testLinkList()
//        
//        testDoublyLinkList()
        testSkipList()
    }

    func testSkipList() {
        var skipList = SkipLisk<Int, NSString>()
        var set = Set<Int>()
        let arr = [63, 41, 41, 22, 31, 74, 60, 61, 26, 19, 53, 44, 15, 41, 63, 68, 75, 71, 80, 92, 90, 91, 97]
        
        for i in 0..<arr.count {
            let key = arr[i] //Int.random(in: 0..<100)
            set.insert(key)
            skipList.setValue(NSString(format: "{index:%2d, key: %2d}", i, key), for: key)
        }
        
        for r in  [63, 41, 41, 22, 31, 74, 60, 100, 300] {
            set.remove(r)
            skipList.removeValue(for: r)
        }
        
        print(skipList.debugDescription)
        
        print("\n\n")
        for _ in 0..<5 {
            let key = Int.random(in: 0..<100)
            let value = skipList.valueFor(key)
            if set.contains(key) {
                assert(value != nil)
            } else {
                assert(value == nil)
            }
            print("value For key\(key): \(value ?? "<nil>")")
        }
        assert(set.count == skipList.count)
        
        let keys = skipList.map { (key, _) -> Int in key }
        let set1 = Set<Int>(keys)
        let set2 = set
        
        assert(set1 == set2)
    }
}
//
//extension ViewController {
//
//    func testLinkList() {
//        var linkList = SingleLinkList(contentsOf: 1...9)
//        print(linkList.debugDescription)
//        linkList.removeLast()
//        print(linkList.debugDescription)
//        linkList.removeFirst()
//        print(linkList.debugDescription)
//        linkList.insert(44, at: 3)
//        print(linkList.debugDescription)
//        linkList.append(33)
//        print(linkList.debugDescription)
//        linkList.append(contentsOf: 100..<109)
//        print(linkList.debugDescription)
//        linkList.remove(at: 17)
//        print(linkList.debugDescription)
//        linkList.remove(at: 1)
//        print(linkList.debugDescription)
//        linkList.insert(10086, after: 107)
//        print(linkList.debugDescription)
//        linkList.insert(10010, before: 2)
//        print(linkList.debugDescription)
//        linkList.insert(10009, before: 44)
//        print(linkList.debugDescription)
//        print(linkList[17])
//        linkList[17] = 17
//        print(linkList.debugDescription)
//        print(linkList.contains(4))
//        print(linkList.contains(20))
//        linkList.reverse()
//        print(linkList.debugDescription)
//    }
//
//
//    func testDoublyLinkList() {
//        var linkList = DoublyLinkList(contentsOf: 1...9)
//        print(linkList.debugDescription)
//        linkList.removeLast()
//        print(linkList.debugDescription)
//        linkList.removeFirst()
//        print(linkList.debugDescription)
//        linkList.insert(44, at: 3)
//        print(linkList.debugDescription)
//        linkList.append(33)
//        print(linkList.debugDescription)
//        linkList.append(contentsOf: 100..<109)
//        print(linkList.debugDescription)
//        linkList.remove(at: 17)
//        print(linkList.debugDescription)
//        linkList.remove(at: 1)
//        print(linkList.debugDescription)
//        linkList.insert(10086, after: 107)
//        print(linkList.debugDescription)
//        linkList.insert(10010, before: 2)
//        print(linkList.debugDescription)
//        linkList.insert(10009, before: 44)
//        print(linkList.debugDescription)
//        print(linkList[17])
//        linkList[17] = 17
//        print(linkList.debugDescription)
//        print(linkList.contains(4))
//        print(linkList.contains(20))
//        linkList.reverse()
//        print(linkList.debugDescription)
//    }
//}