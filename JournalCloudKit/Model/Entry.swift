//
//  Entry.swift
//  JournalCloudKit
//
//  Created by Carson Buckley on 4/8/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation
import CloudKit

class Entry {
    let title: String
    let body: String
    let timestamp: Date
    let ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)){
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord){
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
            let body = ckRecord[EntryConstants.BodyKey] as? String,
            let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date else { return nil }
        
        self.init(title: title, body: body, timestamp: timestamp, ckRecordID: ckRecord.recordID)
    }
}

extension CKRecord{
    convenience init(entry: Entry){
        self.init(recordType: EntryConstants.RecordType, recordID: entry.ckRecordID)
        self.setValue(entry.title, forKey: EntryConstants.TitleKey)
        self.setValue(entry.body, forKey: EntryConstants.BodyKey)
        self.setValue(entry.timestamp, forKey: EntryConstants.TimestampKey)
    }
}

struct EntryConstants{
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let RecordType = "Entry"
}
