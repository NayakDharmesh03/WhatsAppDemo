//
//  myUserData.swift
//  NewAppProject
//
//  Created by NT 2 on 16/03/23.
//

import Foundation
import UIKit





struct DatabaseKey {
    static let userTblName = "user_detail"
    
    static let userIdKey = "id"
    static let userFirstNameKey = "firstname"
    static let userLastNameKey = "lastname"
    static let userEmailkey = "email"
    static let userPasswordKey = "password"
    static let userMobileNoKey = "mobile"
    
    //new field
    static let userDateOfbirthKey = "dateofbirth"
    static let userBirthTimeKey = "birthtime"
    static let userCountryKey = "country"
    static let userStateKey = "state"
    static let userCityKey = "city"
    static let userGenderKey = "gender"
    
    
    
    static let userAboutKey = "aboutme"
    static let userProfileImageKey = "image_url"

    
}

struct userDataKey {
    
    static let userIdKey = "id"
    static let userFirstNameKey = "firstname"
    static let userLastNameKey = "lastname"
    static let userEmailkey = "email"
    static let userPasswordKey = "password"
    static let userMobileNoKey = "mobile"
    
    //new field
    static let userDateOfbirthKey = "dateofbirth"
    static let userBirthTimeKey = "birthtime"
    static let userCountryKey = "country"
    static let userStateKey = "state"
    static let userCityKey = "city"
    static let userGenderKey = "gender"
    
    static let userAboutKey = "aboutme"
    static let userProfileImageKey = "image_url"

}


// MARK:- User Defaults Data Save

func userDefaultsDataSave (strid:String,strfirstname:String,strlastname:String, stremail:String , strpass:String, strmobileNo:String,strdateofbirth:String,strbirthtime:String,strcountry:String,strstate:String,strcity:String,strgender:String,straboutme:String,strImg:String) {

    let userDefaults = UserDefaults.standard
    
    userDefaults.set(strid, forKey: userDataKey.userIdKey)
    userDefaults.set(strfirstname, forKey: userDataKey.userFirstNameKey)
    userDefaults.set(strlastname, forKey: userDataKey.userLastNameKey)
    userDefaults.set(stremail, forKey: userDataKey.userEmailkey)
    userDefaults.set(strpass, forKey: userDataKey.userPasswordKey)
    userDefaults.set(strmobileNo, forKey: userDataKey.userMobileNoKey)
    
    //new field
    userDefaults.set(strdateofbirth, forKey: userDataKey.userDateOfbirthKey)
    userDefaults.set(strbirthtime, forKey: userDataKey.userBirthTimeKey)
    userDefaults.set(strcountry, forKey: userDataKey.userCountryKey)
    userDefaults.set(strstate, forKey: userDataKey.userStateKey)
    userDefaults.set(strcity, forKey: userDataKey.userCityKey)
    userDefaults.set(strgender, forKey: userDataKey.userGenderKey)

    
    userDefaults.set(straboutme, forKey: userDataKey.userAboutKey)
    userDefaults.set(strImg, forKey: userDataKey.userProfileImageKey)


    
    userDefaults.synchronize()
}

// MARK:- Remove Data From User Defaults

func removeDataFromuserDefaults() {
    let userDefaults = UserDefaults.standard
    userDefaults.removeObject(forKey:userDataKey.userIdKey )
    userDefaults.removeObject(forKey:userDataKey.userFirstNameKey )
    userDefaults.removeObject(forKey:userDataKey.userLastNameKey )
    userDefaults.removeObject(forKey:userDataKey.userEmailkey )
    userDefaults.removeObject(forKey:userDataKey.userPasswordKey )
    userDefaults.removeObject(forKey:userDataKey.userMobileNoKey )
    
    //new field
    userDefaults.removeObject(forKey:userDataKey.userDateOfbirthKey )
    userDefaults.removeObject(forKey:userDataKey.userBirthTimeKey )
    userDefaults.removeObject(forKey:userDataKey.userCountryKey )
    userDefaults.removeObject(forKey:userDataKey.userStateKey)
    userDefaults.removeObject(forKey:userDataKey.userCityKey)
    userDefaults.removeObject(forKey:userDataKey.userGenderKey)
    
    userDefaults.removeObject(forKey:userDataKey.userAboutKey )
    userDefaults.removeObject(forKey:userDataKey.userProfileImageKey )

    userDefaults.synchronize()
    
  
}

// MARK:- get data form userdefaults

func getDataFromDefaults(completion:@escaping (Bool,String,String,String,String,String,String,String,String,String,String,String,String,String,String)->()) {
    
    let userDefaults = UserDefaults.standard
    guard let id = userDefaults.value(forKey: userDataKey.userIdKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let firstname = userDefaults.value(forKey: userDataKey.userFirstNameKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let lastname = userDefaults.value(forKey: userDataKey.userLastNameKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let email = userDefaults.value(forKey: userDataKey.userEmailkey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let password = userDefaults.value(forKey: userDataKey.userPasswordKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let mobileNo = userDefaults.value(forKey: userDataKey.userMobileNoKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    
    //---------new data added
    guard let dateofbirth = userDefaults.value(forKey: userDataKey.userDateOfbirthKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let birthtime = userDefaults.value(forKey: userDataKey.userBirthTimeKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let country = userDefaults.value(forKey: userDataKey.userCountryKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let state = userDefaults.value(forKey: userDataKey.userStateKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let city = userDefaults.value(forKey: userDataKey.userCityKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let gender = userDefaults.value(forKey: userDataKey.userGenderKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    //------------
    
    guard let aboutMe = userDefaults.value(forKey: userDataKey.userAboutKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    guard let image_url = userDefaults.value(forKey: userDataKey.userProfileImageKey) as? String else {
        completion(false, "","","","","","","","","","","","","","")
        return
    }
    completion(true, id, firstname, lastname, email, password, mobileNo, dateofbirth,birthtime,country,state,city,gender,aboutMe, image_url)

}
