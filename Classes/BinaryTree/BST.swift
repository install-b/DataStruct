//
//  BST.swift
//  DataStruct
//
//  Created by Shangen Zhang on 2020/7/26.
//

import Foundation

/// 比较
public typealias BSTElementCompare<E> = (_ e1: E, _ e2: E) -> ComparisonResult

/// 遍历
public typealias BSTElementEnumer<E> = (_ e: E) -> Void


/// 二叉搜索树
public protocol BST {
    /// 泛型类型
    associatedtype Element
    
    /// 根节点
    var root: BTNode<Element>? { get set }
    
    /// 比较器
    var cmp: BSTElementCompare<Element> { get }
    
    
    /// 构建节点
    /// - Parameter val: 元素值
    func createNode(with val: Element, parent: BTNode<Element>?) -> BTNode<Element>
    
    
    /// 插入了新的元素
    /// - Parameters:
    ///   - node: 新元素的节点
    ///   - parent: 插入的新元素父节点
    func didInsert(_ node: BTNode<Element>, parent: BTNode<Element>, isLeft: Bool)
}


/// insert remove
public extension BST {

    /// 插入元素
    /// - Parameter element: 插入的新元素
    /// - Returns: 之前存在相同的值,返回之前存在的值
    mutating func insert(_ element: Element) -> Element? {
        guard var node = root else {
            /// 插入根节点
            root = createNode(with: element, parent: nil)
            return nil
        }
        
        while true {
            switch cmp(element, node.val) {
            case .orderedSame:
                /// 存在相同的元素 替换掉
                let origin = node.val
                node.val = element
                return origin
            case .orderedAscending:
                if let next = node.left {
                    node = next
                } else {
                    /// 插入该节点的左边
                    let newNode = createNode(with: element, parent: node)
                    node.left = newNode
                    /// 这里维持平衡的代码交给实体类解决
                    didInsert(newNode, parent: node, isLeft: true)
                    return nil
                }
            case .orderedDescending:
                if let next = node.right {
                    node = next
                } else {
                    /// 插入该节点的右边
                    let newNode = createNode(with: element, parent: node)
                    node.right = newNode
                    /// 这里维持平衡的代码交给实体类解决
                    didInsert(newNode, parent: node, isLeft: false)
                    return nil
                }
            }
        }
        
        
    }
    
    /// 移除元素
    /// - Parameter element: 要移除的元素
    /// - Returns: 若存在该值则返回之前存储的值
    mutating func remove(_ element: Element) -> Element? {
        guard var node = root else {
            return nil
        }
        
        while true {
            switch cmp(element, node.val) {
            case .orderedSame:
                let origin = node.val
                /// 移除Node
                
                return origin
            case .orderedAscending:
                guard let next = node.left else { return nil }
                 node = next
            case .orderedDescending:
                guard let next = node.right else { return nil }
                 node = next
            }
        }
    }
}


/// 遍历操作
public extension BST {
    
    /// 前序遍历
    /// - Parameters:
    ///   - leftFirst: 是否先遍历左边
    ///   - block: 遍历回调block
    func preoderTranersal(leftFirst: Bool = true, using block: BSTElementEnumer<Element>) {
        func tranersalLeftFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            block(node.val)
            tranersalLeftFirst(node: node.left)
            tranersalLeftFirst(node: node.right)
        }
        func tranersalRightFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            block(node.val)
            tranersalRightFirst(node: node.right)
            tranersalRightFirst(node: node.left)
        }
        
        leftFirst ? tranersalLeftFirst(node: root) : tranersalRightFirst(node: root)
    }
    
    /// 后续遍历
    /// - Parameters:
    ///   - leftFirst: 是否先遍历左边
    ///   - block: 遍历回调block
    func postoderTranersal(leftFirst: Bool = true, using block: BSTElementEnumer<Element>) {
        func tranersalLeftFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            tranersalLeftFirst(node: node.left)
            tranersalLeftFirst(node: node.right)
            block(node.val)
        }
        func tranersalRightFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            tranersalRightFirst(node: node.right)
            tranersalRightFirst(node: node.left)
            block(node.val)
        }
        
        leftFirst ? tranersalLeftFirst(node: root) : tranersalRightFirst(node: root)
    }
    
    /// 中序遍历
    /// - Parameters:
    ///   - leftFirst: 是否先遍历左边
    ///   - block: 遍历回调block
    func inoderTranersal(leftFirst: Bool = true, using block: BSTElementEnumer<Element>) {
        func tranersalLeftFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            tranersalLeftFirst(node: node.left)
            block(node.val)
            tranersalLeftFirst(node: node.right)
        }
        func tranersalRightFirst(node: BTNode<Element>?) {
            guard let node = node else { return }
            tranersalRightFirst(node: node.right)
            block(node.val)
            tranersalRightFirst(node: node.left)
        }
        
        leftFirst ? tranersalLeftFirst(node: root) : tranersalRightFirst(node: root)
    }
    
    /// 层序遍历
    /// - Parameters:
    ///   - leftFirst: 是否先遍历左边
    ///   - block: 遍历回调block
    func leveloderTranersal(leftFirst: Bool = true, using block: BSTElementEnumer<Element>) {
        guard let node = root else { return }
        
        var nodes = [node]
        
        if leftFirst {
            while !nodes.isEmpty {
                let n = nodes.removeFirst()
                if let left = n.left {
                    nodes.append(left)
                }
                if let right = n.right {
                    nodes.append(right)
                }
                block(n.val)
            }
        } else {
            while !nodes.isEmpty {
                let n = nodes.removeFirst()
                if let right = n.right {
                    nodes.append(right)
                }
                if let left = n.left {
                    nodes.append(left)
                }
                block(n.val)
            }
        }
    }
}
