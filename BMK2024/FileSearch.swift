//
//  FileSearch.swift
//  BMK2024
//
//  Created by Scott on 2024/11/9.
//

import SwiftUI

struct FileSearchView: View {
    @State private var number:String=""
    @State private var msg:String=""
    var body: some View {
        VStack {
            TextField("请输入与工单号相关的句子", text: $number).padding(10).onChange(of: number){
//                print("changed")
                self.msg=""
            }.onSubmit {
                if let location = readJSONFileFromBundle(filename: "location", fileType: "json") {
//                    print("Latitude: \(location.task_folders)")
                    for folder in location.task_folders{
                        listFilesInDirectory(atPath: folder)
                    }
                
//                    listFilesInDirectory(atPath:   "/Users/scott/go/src/github.com/scott-x/dev_templates")
                }else{
                    return
                }
            }
            .padding()
        }
    }
}
