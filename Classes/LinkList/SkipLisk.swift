//
//  SkipLisk.swift
//  DataStruct
//
//  Created by Shangen Zhang on 2020/7/25.
//

import Foundation

/// 跳表最大层数
fileprivate let MAX_LEVEL: Int = 16

/// 跳表节点
fileprivate final class Node<K, V>: CustomDebugStringConvertible {

    /// 元素关联的KEY
    var key: K
    
    /// data
    var val: V
    
    /// 索引列表
    var nexts: [Node<K, V>?]
    
    /// 下一个节点
    var next: Node<K, V>? {
        nexts.first ?? nil
    }
    
    /// 构造方法
    init(key: K, val: V, level: Int) {
        self.key = key
        self.val = val
        self.nexts = Array(repeating: nil, count: level)
    }
    
    ///自定义打印
    var debugDescription: String {
        return "key: \(key) value: \(val), level: \(nexts.count)"
    }
}

/// 跳表
public struct SkipLisk<K, V> {
    /// 虚拟头结点
    private var dummyHead: [Node<K, V>?] = Array(repeating: nil, count: MAX_LEVEL)
    
    /// 节点个数
    public private(set) var count: Int = 0
    /// 是否为空
    public var isEmpty: Bool {
        count == 0
    }
    
    /// 层数
    private var level: Int = 0
    
    /// 比较器
    private let compare: (K, K) -> ComparisonResult
    
    
    /// 构造方法
    /// - Parameter compare: 比较器
    public init(compare: @escaping (K, K) -> ComparisonResult) {
        self.compare = compare
    }
    
    /// 自定义打印
    public var debugDescription: String {
        var str = "<head(count: \(count), level: \(level)>"
        var node = dummyHead.first ?? nil
        
        while node != nil {
            str += "\n" + node!.debugDescription
            node = node?.next
        }
        return str
    }
}

extension SkipLisk where K: Comparable {
    /// KEY 值具备可比性
    public init() {
        self.compare = { (k1, k2) -> ComparisonResult in
            if k1 == k2 {
                return .orderedSame
            }
            return k1 < k2 ? .orderedAscending : .orderedDescending
        }
    }
}

public extension SkipLisk {
    
    /// 获取数据
    /// - Parameter key: 关联的key
    func valueFor(_ key: K) -> V? {
        
        guard level > 0 else { return nil }
        var nexts = dummyHead
        var l = level - 1
        while l >= 0 {
            guard let node = nexts[l] else {
                l -= 1
                continue
            }
            switch compare(key, node.key) {
            case .orderedSame:
                return node.val
            case .orderedDescending:
                nexts = node.nexts
            default:
                l -= 1
            }
        }
        return nil
    }
    
    /// 设置Value Data
    /// - Parameters:
    ///   - val: data value
    ///   - key: 关联的Key
    @discardableResult
    mutating func setValue(_ val: V, for key: K) -> V? {
        guard level > 0 else {
            /// 没有元素存在 插入第一个元素
            let currentLevel = randomLevel()
            let newNode = Node(key: key, val: val, level: currentLevel)
            for i in 0..<currentLevel {
                dummyHead[i] = newNode
            }
            level = currentLevel
            count = 1
            return nil
        }
        var nexts = dummyHead
        var prevsNexts: [Node<K, V>] = []
        var l = level - 1
        var lastNode: Node<K, V>?
        
        while l >= 0 {
            guard let node = nexts[l] else {
                l -= 1
                if let node = lastNode {
                    prevsNexts.isEmpty ? prevsNexts.append(node) : prevsNexts.insert(node, at: 0)
                }
                continue
            }
            switch compare(key, node.key) {
            case .orderedSame:
                let orgin = node.val
                node.val = val
                return orgin
            case .orderedDescending:
                // key > node.key 穿过该节点进入下个节点
                nexts = node.nexts
                lastNode = node
            default:
                /// key < node.key 回调j降低索引
                l -= 1
                if let node = lastNode {
                    prevsNexts.isEmpty ? prevsNexts.append(node) : prevsNexts.insert(node, at: 0)
                }
            }
        }
        
        let currentLevel = randomLevel()
        let newNode = Node(key: key, val: val, level: currentLevel)
        
        for i in 0..<currentLevel {
            if i < prevsNexts.count {
                /// 连接下一个线
                newNode.nexts[i] = prevsNexts[i].nexts[i]
                /// 连接上一个线
                prevsNexts[i].nexts[i] = newNode
            } else {
                /// 连接下一个线
                newNode.nexts[i] = dummyHead[i]
                /// 连接上一个线
                dummyHead[i] = newNode
            }
        }
        count += 1
        level = max(level, currentLevel)
        return nil
    }

    
    /// 移除元素
    /// - Parameter key: 关联的key
    @discardableResult
    mutating func removeValue(for key: K) -> V? {
        guard level > 0 else {
            /// 没有元素存在
            return nil
        }
        var nexts = dummyHead
        var prevsNexts: [Node<K, V>] = []
        var l = level - 1
        var lastNode: Node<K, V>?
        
        while l >= 0 {
            guard let node = nexts[l] else {
                l -= 1
                if let node = lastNode {
                    prevsNexts.isEmpty ? prevsNexts.append(node) : prevsNexts.insert(node, at: 0)
                }
                continue
            }
            switch compare(key, node.key) {
            case .orderedDescending:
                // key > node.key 穿过该节点进入下个节点
                nexts = node.nexts
                lastNode = node
            default:
                /// key < node.key 回调j降低索引
                l -= 1
                if let node = lastNode {
                    prevsNexts.isEmpty ? prevsNexts.append(node) : prevsNexts.insert(node, at: 0)
                }
            }
        }
        /// 找到前驱 并且当前Key值一致
        guard let node = lastNode?.next, compare(key, node.key) == .orderedSame else { return nil }
        
        let orgin = node.val
        //这里进行删除
        let currentLevel = node.nexts.count
        for index in 0..<currentLevel {
            if !prevsNexts.isEmpty, 0..<prevsNexts.count ~= index {
                prevsNexts[index].nexts[index] = node.nexts[index]
            } else {
                dummyHead[index] = node.nexts[index]
            }
            
        }
        count -= 1
        //assert(count == realCount())
        /// 更新层数
        if currentLevel == level {
            updateLevel(currentLevel)
        }
        return orgin
    }
}



public extension SkipLisk {
    
    /// 转为数组
    /// - Parameter transform: 转换block
    /// - Returns: 转化结果
    func map<T>(_ transform: (_ key: K, _ value: V) throws -> T) rethrows -> [T] {
        var results = [T]()
        var node = dummyHead[0]
        while node != nil {
            results.append(try transform(node!.key, node!.val))
            node = node?.next
        }
        
        return results
    }
    
    
    /// 转为数组
    /// - Parameter transform: 转换block 返回nil 时不加入数组
    /// - Returns: 转化结果
    func compactMap<ElementOfResult>(_ transform: (_ key: K, _ value: V) throws -> ElementOfResult?) rethrows -> [ElementOfResult] {
        var results = [ElementOfResult]()
        var node = dummyHead[0]
        while node != nil {
            if let e = try transform(node!.key, node!.val) {
                results.append(e)
            }
            
            node = node?.next
        }
        
        return results
    }
    
    /// 遍历操作
    /// - Parameter body: 遍历Block
    func forEach(_ body: (_ key: K, _ value: V) throws -> Void) rethrows {
        var node = dummyHead[0]
        while node != nil {
            try body(node!.key, node!.val)
            node = node?.next
        }
    }
}


private extension SkipLisk {
    
    /// 随机层
    func randomLevel() -> Int {
        var level = 1
        while Int.random(in: 0...1) == 0, level < MAX_LEVEL {
            level += 1
        }
        return level
    }
    
    /// 更新层级
    mutating func updateLevel(_ removedLevel: Int) {
        if count == 0 {
            level = 0
            return
        }
        for i in 1..<MAX_LEVEL where dummyHead[i] == nil {
            level = i
            return
        }
        level = MAX_LEVEL
    }
}
