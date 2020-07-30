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
    mutating func didInsert(_ node: BTNode<Element>, parent: BTNode<Element>, isLeft: Bool)
    
    
    /// 移除了新的元素
    /// - Parameters:
    ///   - parent: 被移除元素的父节点
    ///   - grand: 被移除元素的祖父节点
    mutating func didRemoveNode( parent: BTNode<Element>, grand: BTNode<Element>?)
}

/// insert remove
public extension BST {

    /// 插入元素
    /// - Parameter element: 插入的新元素
    /// - Returns: 之前存在相同的值,返回之前存在的值
    @discardableResult
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
                    check()
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
                    check()
                    return nil
                }
            }
        }
        
        
    }
    
    /// 移除元素
    /// - Parameter element: 要移除的元素
    /// - Returns: 若存在该值则返回之前存储的值
    @discardableResult
    mutating func remove(_ element: Element) -> Element? {
        guard var node = root else {
            return nil
        }
        
        while true {
            switch cmp(element, node.val) {
            case .orderedSame:
                let origin = node.val
                guard  let replaceNode = node.getBSTReplaceNode() else {
                    // 删除的是叶子节点
                    
                    if let parent = node.parent {
                        if isSameObject(parent.left, node) {
                            parent.left = nil
                        } else {
                            parent.right = nil
                        }
                        didRemoveNode(parent: parent, grand: parent.parent)
                    } else {
                        // 没有替换的节点几位根节点
                        root = nil
                    }
                    check()
                    return origin
                }
                /// 实际被 移除Node 的父节点
                var removeParent: BTNode<Element>?
                
                if let child = replaceNode.isLeft ? replaceNode.node.right : replaceNode.node.left {
                    child.parent = replaceNode.node.parent
                    if isSameObject(replaceNode.node.parent?.left, replaceNode.node) {
                        child.parent?.left = child
                    } else {
                        child.parent?.right = child
                    }
                    
                    removeParent = child
                } else {
                    removeParent = replaceNode.node
                    if let p = replaceNode.node.parent, isSameObject(p.left, replaceNode.node) {
                        removeParent?.parent?.left = nil
                    } else {
                       removeParent?.parent?.right = nil
                    }
                    removeParent?.parent = nil
                }
                replaceNode.node.left = node.left
                node.left?.parent = replaceNode.node
                replaceNode.node.right = node.right
                node.right?.parent = replaceNode.node
                replaceNode.node.parent = node.parent
                if let p = node.parent  {
                    if isSameObject(p.left, node) {
                        p.left = replaceNode.node
                    } else {
                        p.right = replaceNode.node
                    }
                } else {
                    root = replaceNode.node
                }
                /// 高度发生了变化
                check()
                didRemoveNode(parent: removeParent!, grand: removeParent?.parent)
                check()
                // 删除元素
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
    
    func check() {
        guard let node = root else { return }
        var nodes = [node]
        while !nodes.isEmpty {
            let n = nodes.removeFirst()
            if let left = n.left {
                nodes.append(left)
                assert(isSameObject(left.parent, n))
            }
            if let right = n.right {
                nodes.append(right)
                assert(isSameObject(right.parent, n))
            }

        }
    }
}


extension BST {
    /// 即将旋转
    private mutating func prepareMakeRatio(_ node: BTNode<Element>, child: BTNode<Element>) {
        if let parent = node.parent {
            if isSameObject(parent.left, node) {
                parent.left = child
            } else {
                parent.right = child
            }
            child.parent = parent
        } else {
            root = child
            child.parent = nil
        }
        //
        node.parent = child
    }
    
    
    /// 右旋转
    /// - Parameters:
    ///   - node: 需要旋转的节点
    ///   - lChild: 旋转节点的左子节点
    mutating func makeRightRatio(_ node: BTNode<Element>, lChild: BTNode<Element>) {
 
       prepareMakeRatio(node, child: lChild)
        
        let orginRight = lChild.right
        lChild.right = node
        node.left = orginRight
        orginRight?.parent = node
    }
    
    
    /// 左旋转
    /// - Parameters:
    ///   - node: 需要旋转的节点
    ///   - rChild: 旋转节点的右子节点
    mutating func makeLeftRatio(_ node: BTNode<Element>, rChild: BTNode<Element>) {
    
        prepareMakeRatio(node, child: rChild)
       
        let orginRight = rChild.left
        rChild.left = node
        node.right = orginRight
        orginRight?.parent = node
    }

}
