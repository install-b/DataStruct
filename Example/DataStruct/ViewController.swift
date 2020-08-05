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
//        
//        testSkipList()
        
//        bstAVLTest()
        bstRBTest()
    }
}

extension ViewController {

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

extension ViewController {
    func testSkipList() {
        var skipList = SkipLisk<Int, NSString>()
        var set = Set<Int>()
        let arr = [63, 41, 41, 22, 31, 74, 60, 61, 26, 19, 53, 44, 15, 41, 63, 68, 75, 71, 80, 92, 90, 91, 97]
        
        for i in 0..<arr.count {
            let key = arr[i]
            let value = NSString(format: "{index:%2d, key: %2d}", i, key)
            set.insert(key)
            if let orgin = skipList.setValue(value, for: key) {
                print("set value: \n\(value) \n did replace origin: \n\(orgin)\n")
            }
        }
        assert(set.count == skipList.count)
        for r in  [63, 41, 41, 22, 31, 74, 60, 100, 300] {
            set.remove(r)
            skipList.removeValue(for: r)
        }
        assert(set.count == skipList.count)
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

extension ViewController {
    func bstAVLTest() {
        var avl = AVLTree<Int>()
        func printBST() {
            /// 中序遍历
            print("\n中序遍历:")
            avl.inoderTranersal {
                print($0)
            }
            print("\n前序遍历:")
            avl.preoderTranersal {
                print($0)
            }
            print("\n后序遍历:")
            avl.postoderTranersal {
                print($0)
            }
            print("\n层序遍历:")
            avl.leveloderTranersal {
                print($0)
            }
        }
//        avl.insert(10)
//        avl.insert(5)
//        avl.insert(8)
//        //printBST()
//        avl.insert(15)
//        //printBST()
//        avl.insert(20)
//        //printBST()
//        avl.insert(17)
        
        (1...20).forEach {
            avl.insert($0)
        }
        //printBST()
        //avl.check()
        assert(avl.count == 20)
        (1...3).forEach {
            avl.remove($0 * 3)
        }
        assert(avl.count == 20 - 3)
        printBST()
        avl.remove(8)
        //assert(avl.check() == 20 - 3 - 1)
        avl.remove(1)
        avl.remove(5)
        assert(avl.count == 20 - 3  - 1 - 2)
        avl.insert(10)
        //assert(avl.check() == avl.count && avl.count == 20 - 3  - 1 - 2)
        
        print("\n----------------------------------\n")
         printBST()
        print("\n\n\n-----------------------\n\n\n \(avl.root?.printTreeNode() ?? "nil")")
    }
    
    
    func bstRBTest() {
        var rb = RBTree<Int>()
        func printBST() {
            /// 中序遍历
            print("\n中序遍历:")
            rb.inoderTranersal {
                print($0)
            }
            print("\n前序遍历:")
            rb.preoderTranersal {
                print($0)
            }
            print("\n后序遍历:")
            rb.postoderTranersal {
                print($0)
            }
            print("\n层序遍历:")
            rb.leveloderTranersal {
                print($0)
            }
        }
        
//        (1...10).forEach {
//            rb.insert($0)
//        }
        
        var intArr = [Int]()
        
        for _ in 0..<10_000_000 {
            let number = Int.random(in: 0..<1000000000)
            intArr.append(number)
            
        }
        // 81.1420670747757
        printTime(prefix: "insert RBTree Time = ") {
            intArr.forEach {rb.insert($0)}
        }
//        var avl = AVLTree<Int>()
//        // 248.5733379125595
//        printTime(prefix: "insert AVLTree Time = ") {
//            intArr.forEach {avl.insert($0)}
//        }
        
        var skipList = SkipLisk<Int, Int>()
        // 412.76885199546814
        printTime(prefix: "insert SkipLisk Time = ") {
            intArr.forEach { skipList.setValue($0, for: $0) }
        }
        

        var values = [Int]()
        for _ in 0..<1000 {
            values.append(Int.random(in: 0..<100000000))
        }
        // 0.008895039558410645
        printTime(prefix: "remove RBTree Time = ") {
            
            values.forEach{rb.remove($0)}
        }
        
//        // 0.007248997688293457
//        printTime(prefix: "remove AVLTree Time = ") {
//            values.forEach{avl.remove($0)}
//        }
//        
        // 0.023012995719909668
        printTime(prefix: "remove SkipLisk Time = ") {
            values.forEach{skipList.removeValue(for: $0)}
        }

        var last = Int.min
        rb.inoderTranersal {
            assert($0 > last)
            last = $0
        }
//                var last1 = Int.min
//                avl.inoderTranersal {
//                    assert($0 > last1)
//                    last1 = $0
//                }
        var last2 = Int.min
        skipList.forEach { (key, _) in
            assert(key > last2)
            last2 = key
        }
        //printBST()
        /*
         [14, 80, 55, 59, 29, 19, 75, 56, 47, 52, 47, 84, 37, 73, 23, 12, 49, 81, 96, 90]
         [12, 40, 65, 56, 50, 20, 63, 16, 81, 94, 55, 63, 20, 18, 84, 82, 50, 41, 42, 38]
         [69, 73, 16, 12, 55, 33, 47, 41, 58, 50, 67, 65, 30, 91, 48, 49, 99, 53, 62, 31, 56, 64, 68, 33, 67]
         */
//        let arr = [69, 73, 16, 12, 55, 33, 47, 41, 58, 50, 67, 65, 30, 91, 48, 49, 99, 53, 62, 31, 56, 64, 68]
//
//        arr.forEach {
//            rb.insert($0)
//
//        }
//        print("\n\n\n-----------------------\n\n\n \(rb.root?.printTreeNode() ?? "nil")")
//        print("remove ++++++++++++++++++++++++++ remove")
//        let rmArr = [69, 73, 16, 12, 55, 33, 47, 41, 58, 50, 67, 65]
//        rmArr.forEach {
//            rb.remove($0)
//        }
//        print("\n\n\n-----------------------\n\n\n \(rb.root?.printTreeNode() ?? "nil")")
    }
    
    func printTime(prefix: String = "", block: () -> Void) {
        let t = CFAbsoluteTimeGetCurrent()
        block()
        print(prefix + "\(CFAbsoluteTimeGetCurrent() - t)")
    }
}
