//
//  global.swift
//  BMK2024
//
//  Created by Scott on 2024/11/9.
//

import Foundation

//resource
let    FILE_LOCATION = "location.json"
let    FILE_DB       = "../../bmk.db"

//regexp
let    FolderRe      = "[UCBPMT]A?([12][0-9A-Z]{5})_[0-9A-Z]{3}.*"
let    CaseRe        = ".*[UCBPMT]?A?([12][0-9A-Z]{5})_?[0-9A-Z]{0,3}.*"


//server config
let    PUB     = "/Volumes/bmk_fileserver_Pub"
let     DES     = "/Volumes/bmk_fileserver_Design"
let    DES2    = "/Volumes/data_data_Design"


//options
let    OPTION1 = "存修改点到Pub"
let     OPTION2 = "查看Pub最新修改点"
let   OPTION3 = "搜索并打开所有相关case(支持Pub、Design、data Design)"

