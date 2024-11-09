//
//  db.swift
//  BMK2024
//
//  Created by Scott on 2024/11/9.
//
import SQLite

struct Job {
    let folder:String
    let pure_num:String
}

let jobs = Table("jobs")
let id = Expression<Int64>("id")
let folder = Expression<String>("folder")
let pure_num = Expression<String>("pure_num")

func initDB() {    
    print("init db...")
    do {
        // Define the table and columns
        let db = try Connection(FILE_DB)
        
        // Create table
        try db.run(jobs.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(folder,unique: true)
            t.column(pure_num)
        })
    }catch {
        print (error)
    }
}



//func QueryJob(num:String)<-String {
////    // Query data
////    for user in try db.prepare(users) {
////        print("User: \(user[name]), Age: \(user[age])")
////    }
//
//}



