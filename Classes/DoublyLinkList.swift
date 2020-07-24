//
//  DoublyLinkList.swift
//  DataStruct
//
//  Created by apple on 2020/7/23.
//

import Foundation


extension DoublyLinkList {
    // 双向链表节点
    final class Node<E>: LinkListNode {
        typealias Element = E
        /// 存储的元素
        var val: E
        /// 上一个节点
        var prev: Node<E>?
        /// 下一个节点
        var next: Node<E>?
        
        /// 构造方法
        init(val: E, prev: Node<E>? = nil, next: Node<E>? = nil) {
            self.val = val
            self.prev = prev
            self.next = next
        }
        
        func swpeNextPrev() {
            let temp = prev
            prev = next
            next = temp
        }
    }
}

/// 双向链表
public struct DoublyLinkList<T: Equatable>: LinkList {

    
    public typealias Element = T
        
    // 头结点
    private var header: Node<T>?
    // 尾结点
    private var footer: Node<T>?
    // 节点数量
    public var count: Int = 0
    
    public init() {}
    
    public var first: T? {
        header?.val
    }
    
    public var last: T? {
        /// 最后一个元素
        footer?.val
    }
    
    /// 判断是否为空
    public var isEmpty: Bool {
        count == 0
    }
    
    /// 拼接元素
    public mutating func append(_ element: T) {
        guard let node = footer else {
            let add = Node(val: element)
            header = add
            footer = add
            count = 1
            return
        }
        footer = Node(val: element, prev: node)
        node.next = footer
        count += 1
    }
    
    public mutating func append<S>(contentsOf newElements: S) where S : Sequence, Self.Element == S.Element {
        
        let nodes = newElements.map { Node(val: $0) }
        var pre: Node<T>?
        nodes.forEach {
            pre?.next = $0
            $0.prev = pre
            pre = $0
        }
        
        guard let node = footer else {
            header = nodes.first
            footer = nodes.last
            count = nodes.count
            return
        }
        node.next = nodes.first
        nodes.first?.prev = node
        footer = nodes.last
        count += nodes.count
    }
    /// O(index)   O(count - index)
    public mutating func insert(_ element: T, at index: Int) {
        if index == 0 {
            header = Node(val: element, next: header)
            header?.next?.prev = header
            count += 1
            return
        }
        guard index > 0, index < count else {
            fatalError("insert element index must be < list.count")
        }
        ///  插入的索引小于(count/2) 从前面开始遍历
        if index < count >> 1 {
            var node = header!
            var v = 1
            while v < index {
                node = node.next!
                v += 1
            }
            let next = node.next
            let current = Node(val: element, prev: node, next: next)
            node.next = current
            next?.prev = current
            count += 1
        } else {
            ///插入的索引大于(count/2) 从后面面开始遍历
            let rIndex = count - index
            var node = footer!
            var v = 1
            while v < rIndex {
                node = node.prev!
                v += 1
            }
            let prev = node.prev
            let current = Node(val: element, prev: prev, next: node)
            node.prev = current
            prev?.next = current
            count += 1
        }

    }
    
    /// 插入 pre 之后插入新的元素
    public mutating func insert(_ element: T, after pre: T) {
        guard var node = header else { return }
        while true {
            if node.val == pre {
                let next = node.next
                let current = Node(val: element, prev: node, next: next)
                node.next = current
                next?.prev = current
                if isSameObject(footer, node) {
                    footer = current
                }
                count += 1
                return
            }
            if node.next == nil {
                return
            }
            node = node.next!
        }
    }
    
    /// 在next元素之前插入新的元素
    public mutating func insert(_ element: T, before next: T) {
        guard var node = header else { return }
        var preNode: Node<T>?
        
        while true {
            if node.val == next {
                if let preNode = preNode {
                    let next = preNode.next
                    let current = Node(val: element, prev: preNode, next: next)
                    preNode.next = current
                    next?.prev = current
                    count += 1
                } else {
                    /// 变成头结点
                     let next = header
                    header = Node(val: element, next: header)
                    next?.prev = header
                    count += 1
                }

                return
            }
            if node.next == nil {
                break
            }
            preNode = node
            node = node.next!
        }
    }
    
    /// O(n)
    @discardableResult
    public mutating func remove(at index: Int) -> T? {
        guard let head = header else { return nil }
        if index == 0 {
            header = head.next
            header?.prev = nil
            if header == nil {
                footer = nil
            }
            count -= 1
            return head.val
        }

        guard index > 0, index < count else {
            fatalError("remove element index must be < list.count")
        }
        
        // 获取删除前一个节点
        if index < count >> 1 {
            var preNode = head
            
            if index > 1 {
                for _ in 0..<(index) {
                    preNode = preNode.next!
                }
            }
            
            /// 转移next 关系
            let removed = preNode.next!
            preNode.next = removed.next
            preNode.next?.prev = preNode
            count -= 1
            return removed.val
        } else {
            var removed = footer!
            let rIndex = count - index
            if rIndex > 1 {
                for _ in 0..<(rIndex) {
                    removed = removed.prev!
                }
            }
            removed.prev?.next = removed.next
            removed.next?.prev = removed.prev
            if isSameObject(footer, removed) {
                footer = removed.prev
            }
            count -= 1
            return removed.val
        }

    }
    
    /// O(1)
    @discardableResult
    public mutating func removeFirst() -> T? {
        let val = header?.val
        if count == 1 {
            header = nil
            footer = nil
        } else {
            header = header?.next
            header?.prev = nil
        }
        count -= 1
        return val
    }
    
    /// O(1)
    @discardableResult
    public mutating func removeLast() -> T? {
        let val = footer?.val
        if count == 1 {
            header = nil
            footer = nil
        } else {
            footer = footer?.prev
            footer?.next = nil
        }
        count -= 1
        return val
    }
    
    /// O(n)
    @discardableResult
    public mutating func remove(_ element: T) -> T? {
        guard var node = header else { return nil }
        while true {
            if node.val == element {
                let removeVal = node.val
                node.prev?.next = node.next
                node.next?.prev = node.prev
                count -= 1
                if isSameObject(header, node) {
                     header = node.next
                }
                if isSameObject(footer, node) {
                     footer = node.prev
                }
                return removeVal
            }
            if node.next == nil {
                return nil
            }
            node = node.next!
        }
    }
    
    /// 移除所有的元素
    public mutating func removeAll() {
        /// 移除引用
        var node = header
        while node != nil {
            node?.prev = nil
            node = node?.next
        }
        /// 清空数据
        header = nil
        footer = nil
        count = 0
    }
    
    /// 下标获取元素 替换元素
    public subscript(index: Int) -> T {
        get {
            guard count > 0, 0..<count ~= index else {
                fatalError("beyond index of boundce")
            }
            
            if index < count >> 1 {
                var node = header!
                var c = 0
                while c < index {
                    node = node.next!
                    c += 1
                }
                return node.val
            } else {
                let rIndex = count - index
                var node = footer!
                var c = 1
                while c < rIndex {
                    node = node.prev!
                    c += 1
                }
                return node.val
            }
        }
        set {
            guard count > 0, 0..<count ~= index else {
                fatalError("beyond index of boundce")
            }
            if index < count >> 1 {
                var node = header!
                var c = 0
                while c < index {
                    node = node.next!
                    c += 1
                }
                 node.val = newValue
            } else {
                let rIndex = count - index
                var node = footer!
                var c = 1
                while c < rIndex {
                    node = node.prev!
                    c += 1
                }
                node.val = newValue
            }
        }
    }
    
    /// O(n)
    public func contains(_ element: T) -> Bool {
        guard var node = header else { return false }
        while true {
            if node.val == element { return true }
            if node.next == nil { return false }
            node = node.next!
        }
    }
    public mutating func reverse() {
        var node = header
        while node != nil {
            let temp = node?.next
            node?.swpeNextPrev()
            node = temp
        }
        let temp = header
        header = footer
        footer = temp
    }
}

extension DoublyLinkList {
    /// 打印元素
    public var debugDescription: String {
        var str = "<header>"
        var node = header
        while node != nil {
            str += " -> \(node!.val)"
            node = node?.next
        }
        
        var str1 = "<footer>"
        var node1 = footer
        while node1 != nil {
            str1 += " -> \(node1!.val)"
            node1 = node1?.prev
        }
        
        return "(\(count))" + "\n" +  str + "\n" + str1  + "\n"
    }
}

extension DoublyLinkList {
    
    /// 快速构造
    /// - Parameter elements: 元素集合
    public init<S>(contentsOf elements: S) where S : Sequence, Self.Element == S.Element {
        self.init()
        self.append(contentsOf: elements)
    }
}


public extension DoublyLinkList {
    
    /// 转为数组
    /// - Parameter transform: 转换block
    /// - Returns: 转化结果
    func map<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        try header?.map { return try transform($0) } ?? []
    }
    
    
    /// 转为数组
    /// - Parameter transform: 转换block 返回nil 时不加入数组
    /// - Returns: 转化结果
    func compactMap<ElementOfResult>(_ transform: (Element) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        try header?.compactMap { return try transform($0) } ?? []
    }
    
    /// 遍历操作
    /// - Parameter body: 遍历Block
    func forEach(_ body: (Element) throws -> Void) rethrows {
        try header?.forEach(body)
    }
}
