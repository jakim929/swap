//
//  SynqrCode.swift
//  Swap
//
//  Created by James Kim on 12/6/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import Foundation

struct PropertyKey {
    static let firstNameKey = "fname"
    static let lastNameKey = "lname"
    static let phoneKey = "phone"
    static let emailKey = "email"
    static let fbKey = "facebook"
    static let snapchatKey = "snapchat"
    static let instagramKey = "instagram"
}

class SynqrCode : NSObject, NSCoding {
    
    var fname : String?
    var lname : String?
    var phone : String?
    var email : String?
    var facebook : String?
    var snapchat : String?
    var instagram : String?
    
    override init(){
        
    }
    
    init?(fname: String?, lname: String?, phone: String?, email: String?, facebook: String?, snapchat: String?, instagram : String?){
        self.fname = fname
        self.lname = lname
        self.phone = phone
        self.email = email
        self.facebook = facebook
        self.snapchat = snapchat
        self.instagram = instagram
        
        super.init()
    }
    
    // Mark: Convenient Accessors
    
    func returnValue(number : Int)->String?{
        switch number{
        case 0: return self.fname
        case 1: return self.lname
        case 2: return self.phone
        case 3: return self.email
        case 4: return self.facebook
        case 5: return self.snapchat
        case 6: return self.instagram
        default: return nil
        }
    }
    
    func addValue(number : Int, value : String){
        switch number{
        case 0:  self.fname = value; break
        case 1:  self.lname = value; break
        case 2:  self.phone = value; break
        case 3:  self.email = value; break
        case 4:  self.facebook = value; break
        case 5:  self.snapchat = value; break
        case 6:  self.instagram = value; break
        default: break
        }
    }
    
    func returnArray()->[String]{
        return [unwrap(fname), unwrap(lname), unwrap(phone), unwrap(email), unwrap(facebook), unwrap(snapchat), unwrap(instagram)]
    }
    
    // Mark: Convenient functions

    func unwrap(s: String?) -> String{
        if let value = s {
            return value
        }else
        {
            return ""
        }
    }
    
    // Mark: NSCoding
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(fname, forKey: PropertyKey.firstNameKey)
        aCoder.encodeObject(lname, forKey: PropertyKey.lastNameKey)
        aCoder.encodeObject(phone, forKey: PropertyKey.phoneKey)
        aCoder.encodeObject(email, forKey: PropertyKey.emailKey)
        aCoder.encodeObject(facebook, forKey: PropertyKey.fbKey)
        aCoder.encodeObject(snapchat, forKey: PropertyKey.snapchatKey)
        aCoder.encodeObject(instagram, forKey: PropertyKey.instagramKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let fname = aDecoder.decodeObjectForKey(PropertyKey.firstNameKey) as? String
        let lname = aDecoder.decodeObjectForKey(PropertyKey.lastNameKey) as? String
        let phone = aDecoder.decodeObjectForKey(PropertyKey.phoneKey) as? String
        let email = aDecoder.decodeObjectForKey(PropertyKey.emailKey) as? String
        let facebook = aDecoder.decodeObjectForKey(PropertyKey.fbKey) as? String
        let snapchat = aDecoder.decodeObjectForKey(PropertyKey.snapchatKey) as? String
        let instagram = aDecoder.decodeObjectForKey(PropertyKey.instagramKey) as? String

        self.init(fname: fname, lname: lname, phone: phone, email: email, facebook: facebook, snapchat: snapchat, instagram: instagram)

    }
    
    
    // Mark: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("synqrCode")
    
    
    
    
    
    
}