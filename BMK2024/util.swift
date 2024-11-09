//
//  util.swift
//  BMK2024
//
//  Created by Scott on 2024/11/9.
//
import Cocoa
import Foundation
import SQLite

// 定义  Mydata 结构体，符合 Codable 协议
struct Mydata: Codable {
    let task_folders:[String]
    let ignore_folders:[String]
}

func readJSONFileFromBundle(filename: String, fileType: String) -> Mydata? {
    // 获取文件路径
    if let filePath = Bundle.main.path(forResource: filename, ofType: fileType) {
        let fileURL = URL(fileURLWithPath: filePath)
        
        do {
            // 读取文件内容
            let data = try Data(contentsOf: fileURL)
            
            // 使用 JSONDecoder 来解析 JSON 数据
            let decoder = JSONDecoder()
            let location = try decoder.decode(Mydata.self, from: data)
            return location
        } catch {
            print("Error reading or decoding file: \(error)")
        }
    } else {
        print("File not found in bundle")
    }
    
    return nil
}

func listFilesInDirectory(atPath path: String) {
    
    //init db
    do {
        // Define the table and columns
        let db = try Connection(FILE_DB)
        
        let fileManager = FileManager.default
        
        // folder不存在直接退出
        if !checkIfDirectoryExists(atPath: path) {
            return
        }
        
        do {
            
            // 获取目录下所有文件和子目录的名称（不包括隐藏文件）
            let items = try fileManager.contentsOfDirectory(atPath: path)
            
            // 遍历文件列表
            for item in items {
                let fullPath = (path as NSString).appendingPathComponent(item)
                var isDirectory: ObjCBool = false
                
                // 检查是否是目录
                if fileManager.fileExists(atPath: fullPath, isDirectory: &isDirectory) {
                    if isDirectory.boolValue {
                        print("Directory: \(fullPath)")  // 如果是目录
                        // 递归遍历子目录
    //                    listFilesInDirectory(atPath: fullPath)
                        // Test the method
                        if let base = extractBase(from: fullPath) {
//                            print("dir: \(base)")
                            
                            if let extracted = extractPattern(from: base) {
                                // Insert data
                                let insert = jobs.insert(folder <- fullPath, pure_num <- extracted)
                                try db.run(insert)
//                                print("case: \(extracted)")
                            } else {
                                print("No match found.")
                            }
                        }
                    } else {
    //                    print("File: \(fullPath)")  // 如果是文件
                    }
                }
            }
        } catch {
            print("Error reading directory contents: \(error)")
        }
    }catch {
        print (error)
        return
    }
    
}

func checkIfDirectoryExists(atPath path: String) -> Bool {
    let fileManager = FileManager.default
    var isDirectory: ObjCBool = false
    
    // 检查目录或文件是否存在
    let exists = fileManager.fileExists(atPath: path, isDirectory: &isDirectory)
    
    // 如果存在且是目录，返回 true
    if exists && isDirectory.boolValue {
        return true
    } else {
        return false
    }
}


func checkFilePermission(atPath path: String) {
    let fileManager = FileManager.default
    if fileManager.isReadableFile(atPath: path) {
        print("File is readable.")
    } else {
        print("File is not readable.")
    }
}


func openFolder(atPath path: String) {
    let fileManager = FileManager.default
    
    // 检查文件夹是否存在
    if fileManager.fileExists(atPath: path, isDirectory: nil) {
        let url = URL(fileURLWithPath: path)
        
        // 使用 NSWorkspace 打开文件夹
        NSWorkspace.shared.open(url)
    } else {
        print("The folder does not exist at the given path: \(path)")
    }
}

func extractPattern(from string: String) -> String? {
    // Define the regular expression pattern
    let pattern = FolderRe
    
    do {
        // Create a regular expression object
        let regex = try NSRegularExpression(pattern: pattern, options: [])
        
        // Perform the search
        let range = NSRange(location: 0, length: string.utf16.count)
        if let match = regex.firstMatch(in: string, options: [], range: range) {
            // Extract the matched group (inside parentheses)
            if let range = Range(match.range(at: 1), in: string) {
                return String(string[range])
            }
        }
    } catch {
        print("Invalid regular expression: \(error.localizedDescription)")
    }
    
    return nil
}


func extractBase(from path: String) -> String? {
    // Create a URL object from the string
    let url = URL(fileURLWithPath: path)
    
    // Get the last path component (this will be "category" in this example)
    let result = url.lastPathComponent
   
    if result.hasPrefix(".") || result.hasPrefix("_") || result.hasPrefix("~") {
        return ""
    }

    return result
}
