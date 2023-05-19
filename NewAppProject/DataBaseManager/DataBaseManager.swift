//
//  DataBaseManager.swift
//  NewAppProject
//
//  Created by NT 2 on 10/03/23.
//

import Foundation
import FMDB

final class DataBaseManager{
    
    static let databaseFileName = "MyUserData.db"
    static var database:FMDatabase!
    static let shared: DataBaseManager = {
        let instance = DataBaseManager()
        return instance
    }()
    
    //MARK:- DataBase create
    
    func createDatabse()  {
        
        let bundlePath = Bundle.main.path(forResource: "MyUserData", ofType: ".db")
        print(bundlePath ?? "", "\n") //prints the correct path
        let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent("MyUserData.db")
        let fullDestPathString = fullDestPath!.path
        
        if fileManager.fileExists(atPath: fullDestPathString) {
            print("File is available")
            DataBaseManager.database = FMDatabase(path: fullDestPathString)
            openDataBase()
            print(fullDestPathString)
        }
        else{
            do{
                try fileManager.copyItem(atPath: bundlePath!, toPath: fullDestPathString)
                if fileManager.fileExists(atPath: fullDestPathString) {
                    DataBaseManager.database = FMDatabase(path: fullDestPathString)
                    openDataBase()
                    
                    print("File is copy")
                }else {
                    print("File is not copy")
                }
            }catch{
                print("\n")
                print(error)
            }
        }
    }
    
    
    func openDataBase() {
        if DataBaseManager.database != nil {
            DataBaseManager.database.open()
            //deleteTran()
        }else {
            DataBaseManager.shared.createDatabse()
        }
    }
    
    func closeDataBase() {
        if DataBaseManager.database != nil {
            DataBaseManager.database.close()
        }else {
            
        }
    }
    //MARK:- Checking email exist or not Query
    
    func checkUserEmailisExitOrNot(strEmail:String)->Bool{
        let emailArgs:[Any] = [strEmail]
        let selectQuery = "SELECT * FROM user_detail WHERE email=?"
        self.openDataBase()
        if let result = DataBaseManager.database.executeQuery(selectQuery, withArgumentsIn: emailArgs) {

            while result.next(){

                if let user_email = result.string(forColumn: DatabaseKey.userEmailkey)
                        {
                            if user_email == strEmail{
                                return true
                            }else{
                                return false
                            }
                        }
            }

        } else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }

        return false

    }
    //MARK:- SignUp or insert User data Query

    func signUpUser(strfirstname:String,strlastname:String,stremail:String,strpassword:String,strmobile:String,strdateofbirth:String,strbirthtime:String,strcountry:String,strstate:String,strcity:String,strgender:String,straboutme:String,strImgUrl:String,completion:@escaping (Bool,String)->()){
        
        let myDictionary = ["firstname":strfirstname,"lastname":strlastname,"email":stremail,"password":strpassword,"mobile":strmobile,"dateofbirth":strdateofbirth,"birthtime":strbirthtime,"country":strcountry,"state":strstate,"city":strcity,"gender":strgender,"aboutme":straboutme,"image_url":strImgUrl] as [String : Any]

            if DataBaseManager.database != nil {
                DataBaseManager.database.executeUpdate("INSERT INTO user_detail (firstname,lastname,email,password,mobile,dateofbirth,birthtime,country,state,city,gender,aboutme,image_url) VALUES (:firstname,:lastname,:email,:password,:mobile,:dateofbirth,:birthtime,:country,:state,:city,:gender,:aboutme,:image_url)", withParameterDictionary: myDictionary)
                  completion(true,"Add data")
            }else {
                completion(false, "Databse close")
            }
        }

    // MARK:- User Login Query
    
    func userlogin(email:String,pass:String)->Bool{

        self.openDataBase()
        let selectionArgs:[Any] = [email,pass]

        let selectQuery = "SELECT * FROM user_detail WHERE email=? AND password=?"
        
        if let result = try! DataBaseManager.database.executeQuery(selectQuery, withArgumentsIn: selectionArgs) {
            
            while result.next(){
                
                        if  let u_email = result.string(forColumn: DatabaseKey.userEmailkey),
                        let u_password = result.string(forColumn: DatabaseKey.userPasswordKey),
                        let u_firstname = result.string(forColumn: DatabaseKey.userFirstNameKey),
                        let u_lastname = result.string(forColumn: DatabaseKey.userLastNameKey),
                        let u_mobileno = result.string(forColumn: DatabaseKey.userMobileNoKey),
                        let u_id = result.string(forColumn: DatabaseKey.userIdKey),
                        let u_img = result.string(forColumn: DatabaseKey.userProfileImageKey),
                        
                        //new added
                        let u_country = result.string(forColumn: DatabaseKey.userCountryKey),
                        let u_state = result.string(forColumn: DatabaseKey.userStateKey),
                        let u_city = result.string(forColumn: DatabaseKey.userCityKey),
                        let u_gender = result.string(forColumn: DatabaseKey.userGenderKey),
                        let u_dateofbirth = result.string(forColumn: DatabaseKey.userDateOfbirthKey),
                        let u_birthtime = result.string(forColumn: DatabaseKey.userBirthTimeKey),
                        
                        let u_aboutme = result.string(forColumn: DatabaseKey.userAboutKey){
                                           
                            if u_email == email && u_password == pass{
                                     
                                //MARK:- save data in userDefaults
                                
                                userDefaultsDataSave(strid: u_id, strfirstname: u_firstname, strlastname: u_lastname, stremail: u_email, strpass: u_password, strmobileNo: u_mobileno, strdateofbirth: u_dateofbirth, strbirthtime: u_birthtime, strcountry: u_country, strstate: u_state, strcity: u_city, strgender: u_gender, straboutme: u_aboutme, strImg: u_img)
                                    return true
                                
                            }
                        }
            }
            
        } else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }
                
        return false
    }

    // MARK:- Update UserData Query
    func updateUserData(strUserid:String,strfirstName:String,strlastName:String,strphone:String,strdateofbirth:String,strbirthtime:String,strcountry:String,strstate:String,strcity:String,strgender:String,straboutme:String,strImgUrl:String) -> Bool {
        
            let updateQuery = "UPDATE user_detail SET firstname=?, lastname=?,mobile=?,dateofbirth=?,birthtime=?,country=?,state=?,city=?,gender=?,aboutme=?,image_url=? WHERE id=?"
        
            self.openDataBase()
        
            if let database = DataBaseManager.database {
                
                if database.open() {
                    let updateResult = database.executeUpdate(updateQuery, withArgumentsIn: [strfirstName,strlastName,strphone,strdateofbirth,strbirthtime,strcountry,strstate,strcity,strgender,straboutme,strImgUrl,strUserid])
                    
                    
                    if !updateResult {
                        print("Error updating data: \(database.lastErrorMessage())")
                    }else{
                        self.getUserData(u_id: strUserid)
                        print("Data Updated")
                        
                    }
                    database.close()
                    return updateResult
                }
            }
            return false
        }
    
    
    func matchOldPassword(userId:String,strOldPass:String)->Bool{
        let changeSelectQuery = "SELECT * FROM user_detail WHERE id=?"
        self.openDataBase()
        if let result = DataBaseManager.database.executeQuery(changeSelectQuery, withArgumentsIn: [userId]) {

            while result.next(){

                        if let u_password = result.string(forColumn: DatabaseKey.userPasswordKey)
                        {
                            if u_password == strOldPass{
                                    return true
                            }else{
                                return false
                            }
                        }
            }

        } else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }
        return false

    }
    //MARK:- Chage and Compare old UserPassword Query
    
    func chageUserPassword(userId:String,strOldPass:String,strNewPass:String)->Bool{
        let changeSelectQuery = "SELECT * FROM user_detail WHERE id=?"
        if let result = DataBaseManager.database.executeQuery(changeSelectQuery, withArgumentsIn: [userId]) {

            while result.next(){

                        if let u_password = result.string(forColumn: DatabaseKey.userPasswordKey)
                        {
                            if u_password == strOldPass{
                                
                                    let passUpdateResult =  UpdateUserPassword(strUserid: userId,strNewPass: strNewPass)
                                    return passUpdateResult
                                
                            }else{
                                return false
                            }
                        }
            }

        } else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }

        return false


    }
    //MARK:- Chage or Update old UserPassword Query
    
    func UpdateUserPassword(strUserid:String,strNewPass:String)->Bool{
        
        let updateQuery = "UPDATE user_detail SET password=? WHERE id=?"
    
        self.openDataBase()
    
        if let database = DataBaseManager.database {
            
            if database.open() {
                let updateResult = database.executeUpdate(updateQuery, withArgumentsIn: [strNewPass,strUserid])
                
                
                if !updateResult {
                    print("Error updating data: \(database.lastErrorMessage())")
                }else{
                    self.getUserData(u_id: strUserid)
                    print("Data Updated")
                    
                }
                database.close()
                return updateResult
            }
        }
        return false
    }
    
    
    //MARK:- getUserData and store in User Default
    
    func getUserData(u_id:String) -> Bool{
        
        let selectQuery = "SELECT * FROM user_detail WHERE id=?"
        
        if let result = DataBaseManager.database.executeQuery(selectQuery, withArgumentsIn: [u_id]) {
            
            while result.next(){
                
                        if  let u_email = result.string(forColumn: DatabaseKey.userEmailkey),
                            let u_password = result.string(forColumn: DatabaseKey.userPasswordKey),
                            let u_firstname = result.string(forColumn: DatabaseKey.userFirstNameKey),
                            let u_lastname = result.string(forColumn: DatabaseKey.userLastNameKey),
                            let u_mobileno = result.string(forColumn: DatabaseKey.userMobileNoKey),
                            let u_id = result.string(forColumn: DatabaseKey.userIdKey),
                            
                            //new
                            let u_country = result.string(forColumn: DatabaseKey.userCountryKey),
                            let u_state = result.string(forColumn: DatabaseKey.userStateKey),
                            let u_city = result.string(forColumn: DatabaseKey.userCityKey),
                            let u_gender = result.string(forColumn: DatabaseKey.userGenderKey),
                            let u_dateofbirth = result.string(forColumn: DatabaseKey.userDateOfbirthKey),
                            let u_birthtime = result.string(forColumn: DatabaseKey.userBirthTimeKey),
                            
                            let u_img = result.string(forColumn: DatabaseKey.userProfileImageKey),
                            let u_aboutme = result.string(forColumn: DatabaseKey.userAboutKey){
                                               
                            userDefaultsDataSave(strid: u_id, strfirstname: u_firstname, strlastname: u_lastname, stremail: u_email, strpass: u_password, strmobileNo: u_mobileno, strdateofbirth: u_dateofbirth, strbirthtime: u_birthtime, strcountry: u_country, strstate: u_state, strcity: u_city, strgender: u_gender, straboutme: u_aboutme, strImg: u_img)
                                        return true
                        }else{
                            return false
                        }
                        
            }//End while
        }
        else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }//End if
        return false
        
    }//end getUserData func

}

//MARK:- This is for forgot password updation Queries

extension DataBaseManager{
    
    func UpdateForgotPassword(strEmail:String,strNewPassword:String)->Bool{
        
        let updateQuery = "UPDATE user_detail SET password=? WHERE email=?"
    
        self.openDataBase()
    
        if let database = DataBaseManager.database {
            
            if database.open() {
                let updateResult = database.executeUpdate(updateQuery, withArgumentsIn: [strNewPassword,strEmail])
                
                
                if !updateResult {
                    print("Error updating data: \(database.lastErrorMessage())")
                }else{
                    getForUserData(u_email: strEmail)
                    print("Data Updated")
                    
                }
//                database.close()
                return updateResult
            }
        }
        return false
    }
    
    //MARK:- getForUserData and store in User Default
    
    func getForUserData(u_email:String) -> Bool{
        
        let selectQuery = "SELECT * FROM user_detail WHERE email=?"
        
        if let result = DataBaseManager.database.executeQuery(selectQuery, withArgumentsIn: [u_email]) {
            
            while result.next(){
                
                        if  let u_email = result.string(forColumn: DatabaseKey.userEmailkey),
                            let u_password = result.string(forColumn: DatabaseKey.userPasswordKey),
                            let u_firstname = result.string(forColumn: DatabaseKey.userFirstNameKey),
                            let u_lastname = result.string(forColumn: DatabaseKey.userLastNameKey),
                            let u_mobileno = result.string(forColumn: DatabaseKey.userMobileNoKey),
                            let u_id = result.string(forColumn: DatabaseKey.userIdKey),
                            
                            //new
                            let u_country = result.string(forColumn: DatabaseKey.userCountryKey),
                            let u_state = result.string(forColumn: DatabaseKey.userStateKey),
                            let u_city = result.string(forColumn: DatabaseKey.userCityKey),
                            let u_gender = result.string(forColumn: DatabaseKey.userGenderKey),
                            let u_dateofbirth = result.string(forColumn: DatabaseKey.userDateOfbirthKey),
                            let u_birthtime = result.string(forColumn: DatabaseKey.userBirthTimeKey),
                            
                            let u_img = result.string(forColumn: DatabaseKey.userProfileImageKey),
                            let u_aboutme = result.string(forColumn: DatabaseKey.userAboutKey){
                                               
                            userDefaultsDataSave(strid: u_id, strfirstname: u_firstname, strlastname: u_lastname, stremail: u_email, strpass: u_password, strmobileNo: u_mobileno, strdateofbirth: u_dateofbirth, strbirthtime: u_birthtime, strcountry: u_country, strstate: u_state, strcity: u_city, strgender: u_gender, straboutme: u_aboutme, strImg: u_img)
                                        return true
                        }else{
                            return false
                        }
                        
            }//End while
        }
        else {
            print("Error executing query: \(DataBaseManager.database.lastErrorMessage())")
        }//End if
        return false
        
    }//end getUserData func
}


extension DataBaseManager{
        //MARK:- NEW CHANGES Get All User Name,Mobile,Profile
        
        func getUserContacts(){
            
//            var data = [[String: Any]]()
           
            let query = "SELECT firstname, mobile, image_url FROM user_detail"
            
            if let result = DataBaseManager.database.executeQuery(query, withArgumentsIn: []){
                
                        var obj = UsersContacts()
                        while result.next() {
                        
                            if let u_firstname = result.string(forColumn: DatabaseKey.userFirstNameKey),
                                let u_mobileno = result.string(forColumn: DatabaseKey.userMobileNoKey),
                                let u_img = result.string(forColumn: DatabaseKey.userProfileImageKey){
                                
                                    let row = ["name": u_firstname, "number": u_mobileno, "imageURL": u_img]
                                    obj.userData.append(row)
                                print(obj.userData)

                            }
                               
                        }
            }else{
                print("Not found Data")
            }
        }//end getUserData func

}
