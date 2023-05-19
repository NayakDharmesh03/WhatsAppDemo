//
//  EditProfileData.swift
//  NewAppProject
//
//  Created by NT 2 on 17/03/23.
//

import UIKit

class EditProfileData: UITableViewController {
    
    @IBOutlet var menuView: UIView!
    var user_id = ""
    @IBOutlet var camaraBtn: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileLbl: UILabel!
    
    @IBOutlet var firstnameTextField: UITextField!
    @IBOutlet var lastnameTextFileld: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var mobileNoTextField: UITextField!
    
    @IBOutlet var dobTF: UITextField!
    @IBOutlet var birthTimeTF: UITextField!
    @IBOutlet var countryTF: UITextField!
    @IBOutlet var stateTF: UITextField!
    @IBOutlet var cityTF: UITextField!
    
    @IBOutlet var maleBtn: UIButton!
    @IBOutlet var femaleBtn: UIButton!
    
    @IBOutlet var aboutmeTV: UITextView!
    @IBOutlet var updateBtn: UIButton!
    
    var strImageUrl:String = ""
    var strGender:String = ""
    
    let datePicker1 = UIDatePicker() //for Date selecting
    let datePicker2 = UIDatePicker() //for time selecting
    
    let countryPicker = UIPickerView()
    let statePicker = UIPickerView()
    let cityPicker = UIPickerView()
    
    
    let countriesArr = ["India", "USA", "UK"]
    
    let statesArr = [
        "India": ["Andhra Pradesh", "Maharashtra", "Gujarat"],
        "USA": ["California", "Texas", "Florida"],
        "UK": ["England", "Scotland", "Wales"]
    ]
    let citiesArr = [
        "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur", "Nellore", "Kurnool"],
        "Maharashtra": ["Mumbai", "Pune", "Nagpur", "Nashik", "Aurangabad"],
        "Gujarat": ["Ahmedabad", "Surat", "Vadodara", "Rajkot", "Bhavnagar"],
        
        "California": ["Los Angeles", "San Francisco", "San Diego", "San Jose", "Fresno"],
        "Texas": ["Houston", "San Antonio", "Dallas", "Austin", "Fort Worth"],
        "Florida": ["Miami", "Orlando", "Jacksonville", "Tampa", "St. Petersburg"],
        
        "England": ["London", "Manchester", "Birmingham", "Liverpool", "Leeds"],
        "Scotland": ["Edinburgh", "Glasgow", "Aberdeen", "Dundee", "Inverness"],
        "Wales": ["Cardiff", "Swansea", "Newport", "Bangor", "St. Asaph"]
    ]
    
    var selectedCountryIndex = 0
    var selectedStateIndex = 0
    var selectedCityIndex = 0
    
    var arrSelectedState:[String] = []
    var arrSelectedCity:[String] = []
    
    var selectedCountry = ""
    var selectedState = ""
    var selectedCity = ""
    
    
    //    var selectedState = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //adding TapGestureRecognizer in profile Image
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        profileImage.isUserInteractionEnabled = true
        profileImage.addGestureRecognizer(tapGesture)
        
        
        textFieldDesign()
        allControlsConfiguration()
        
        addBottomLine()
        setArroImage()
        
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        statePicker.dataSource = self
        statePicker.delegate = self
        
        cityPicker.dataSource = self
        cityPicker.delegate = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.getData()
    }
    
    //MARK: - Camera btn tapped Action
    @IBAction func openCamera(_ sender: UIButton) {
        imageViewTapped()
    }
    
    
    //MARK: - Adding Bottum Line in TextView
    func addBottomLine(){
        // Create a new layer with the desired frame and properties
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: aboutmeTV.frame.height - 1, width: aboutmeTV.frame.width*3, height: 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        
        // Add the layer as a sublayer of the text view's layer
        aboutmeTV.layer.addSublayer(bottomLine)
    }
    
    
    func setArroImage(){
        self.countryTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
        self.stateTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
        self.cityTF.setUpImage(imageName: "arrowtriangle.down.fill", on: .right)
    }
    
    func textFieldDesign(){
        
        firstnameTextField.setBottomBorder(color: "#3EFE46")
        lastnameTextFileld.setBottomBorder(color: "#3EFE46")
        emailTextField.setBottomBorder(color: "#3EFE46")
        mobileNoTextField.setBottomBorder(color: "#3EFE46")
        dobTF.setBottomBorder(color: "#3EFE46")
        birthTimeTF.setBottomBorder(color: "#3EFE46")
        countryTF.setBottomBorder(color: "#3EFE46")
        stateTF.setBottomBorder(color: "#3EFE46")
        cityTF.setBottomBorder(color: "#3EFE46")
        
    }
    
    
    func allControlsConfiguration(){
        
        camaraBtn.layer.masksToBounds = false
        camaraBtn.layer.shadowColor = UIColor.black.cgColor
        camaraBtn.layer.shadowOffset = CGSize(width: 0, height: 1)
        camaraBtn.layer.shadowOpacity = 0.5
        camaraBtn.layer.shadowRadius = 3
        camaraBtn.layer.cornerRadius =  camaraBtn.frame.height/2
        camaraBtn.layer.borderWidth = 2
        camaraBtn.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.shadowColor = UIColor.black.cgColor
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        profileImage.layer.shadowOpacity = 0.5
        profileImage.layer.shadowRadius = 3
        profileImage.layer.cornerRadius =  44
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        updateBtn.layer.masksToBounds = true
        updateBtn.layer.cornerRadius =  updateBtn.frame.height/2
        
    }
    
    @IBAction func radioButtonsClicked(_ sender: UIButton) {
        
        if sender.tag == 1{
            maleBtn.isSelected = true
            femaleBtn.isSelected = false
            
            self.strGender = "Male"
            print("Male")
        }
        else if sender.tag == 2{
            maleBtn.isSelected = false
            femaleBtn.isSelected = true
            self.strGender = "Female"
            print("Female")
        }
        
    }
    
    
    //MARK:- Back Button Action
    @IBAction func backButtonClicked(_ sender: UIButton) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    
    //MARK:- updateButton Action
    @IBAction func updateButtonClicked(_ sender: UIButton) {
        
        if firstnameTextField.text == "" && lastnameTextFileld.text == "" && mobileNoTextField.text == "" && dobTF.text == "" && birthTimeTF.text == "" && countryTF.text == "" && stateTF.text == "" && cityTF.text == "" && aboutmeTV.text == ""{
            self.createAlert(strAlert: "Please fill All Data")
            
        }
        else if(firstnameTextField.text == ""){
            self.createAlert(strAlert: "Please enter name first")
            
        }else if(lastnameTextFileld.text == ""){
            self.createAlert(strAlert: "Please enter lastname")
            
        }
        else if mobileNoTextField.text == ""{
            self.createAlert(strAlert: "Please enter mobile number")
            
        }else if isValidPhone(testStr: mobileNoTextField.text!) == false{
            self.createAlert(strAlert: "Please Enter Valid phone")
            
        }
        else if dobTF.text == ""{
            self.createAlert(strAlert: "Please enter date of birth")
            
        }
        else if birthTimeTF.text == ""{
            self.createAlert(strAlert: "Please enter BirthTime")
            
        }
        else if countryTF.text == "" {
            self.createAlert(strAlert: "please select Coutry")
        }
        else if stateTF.text == "" {
            self.createAlert(strAlert: "please select state")
        }
        else if cityTF.text == "" {
            self.createAlert(strAlert: "please select city")
        }
        else if aboutmeTV.text == ""{
            self.createAlert(strAlert: "please enter about me")
        }
        else{
            self.saveProfileImage { success,Message in
                
                if success == true{
                    
                    let updateResult = DataBaseManager.shared.updateUserData(strUserid: self.user_id, strfirstName: self.firstnameTextField.text!, strlastName: self.lastnameTextFileld.text!, strphone: self.mobileNoTextField.text!, strdateofbirth: self.dobTF.text!, strbirthtime: self.birthTimeTF.text!, strcountry: self.countryTF.text!, strstate: self.stateTF.text!, strcity: self.cityTF.text!, strgender: self.strGender, straboutme: self.aboutmeTV.text!, strImgUrl: Message)
                    
                    if updateResult{
                        self.createAlertAndNavigate(strAlert: "Data Updated successufully")
                    }else{
                        print("Data Not Update")
                    }
                }
            }
        }
    }
}
//MARK:- TextField Delegates
extension EditProfileData : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //This is for max character for mobile and password
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else {
            return false
        }
        
        let updateText = currentText.replacingCharacters(in: stringRange, with: string)
        
        if(textField.tag == 1){
            return updateText.count <= 30
        }else if(textField.tag == 2){
            return updateText.count <= 30
        }else if (textField.tag == 4){
            return updateText.count <= 10
        }
        
        return true
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 5{ //dateOfBirth picker open
            openDateDatePicker()
        }else if textField.tag == 6{ //birth time picker open
            openTimeDatePicker()
        }
        else if textField.tag == 7{
            //country list
            openCoutryPickerViewList()
        }else if textField.tag == 8{
            
            if countryTF.text == ""{
                createAlert(strAlert: "First select Country")
            }else{
                //state list
                openStatePickerViewList()
            }
            
        }else if textField.tag == 9{
            if countryTF.text == "" && stateTF.text == ""{
                createAlert(strAlert: "First select Country & State")
            }else if stateTF.text == "" {
                createAlert(strAlert: "First select State")
            }else{
                //City list
                openCityPickerViewList()
            }
            
        }
    }
}

extension EditProfileData {
    
    //MARK:- Save Profile image in Documents
    
    func saveProfileImage(completion:@escaping (Bool,String)->()){
        
        if  let image = profileImage.image {
            
            let imageName = "img" + "\(Date().timeIntervalSince1970)" + ".png"
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent(imageName)
            
            let fullDestPathString = fullDestPath!.path
            
            if !FileManager.default.fileExists(atPath: fullDestPath!.path){
                do{
                    try image.pngData()!.write(to: fullDestPath!)
                    print("Image Added Successfully")
                    completion(true, fullDestPathString)
                    
                }catch{
                    print("Image Not Added")
                    completion(false, "")
                }
            }else {
                
                print("Image Not exist")
                completion(false, "")
            }
        }
    }
    
}
extension EditProfileData{
    
    func documentsDir(strUrl:String) {
        if let url = URL(string: strUrl) {
            
            let destPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let fullDestPath = NSURL(fileURLWithPath: destPath).appendingPathComponent(url.lastPathComponent)
            let fullDestPathString = fullDestPath!.path
            self.profileImage.image = UIImage(contentsOfFile: fullDestPathString)
            
        } else {
            print("Invalid URL")
        }
        
    }
    // MARK:- UserDefault data filled in Textfields here.
    func getData(){
        getDataFromDefaults { success, id, firstname, lastname, email, password, mobileno,dateofbirth,birthtime,country,state,city,gender,aboutme,imgUrl    in
            
            if success == true {
                self.firstnameTextField.text = firstname
                self.lastnameTextFileld.text = lastname
                self.emailTextField.text = email
                self.mobileNoTextField.text = mobileno
                
                self.dobTF.text = dateofbirth
                self.birthTimeTF.text = birthtime
                self.countryTF.text = country
                self.stateTF.text = state
                self.cityTF.text = city
                
                self.selectedCountry = country
                self.selectedState = state
                self.selectedCity = city
                
                
                if self.selectedCountry != ""{
                    if let arst = self.statesArr[self.selectedCountry]{
                        self.arrSelectedState = arst
                    }
                    
                }
                
                if self.selectedState != ""{
                    if let arct = self.citiesArr[self.selectedState]{
                        self.arrSelectedCity = arct
                    }
                }
                
                
                self.strGender = gender
                
                if self.strGender == "Male"{
                    self.maleBtn.isSelected = true
                }else{
                    self.femaleBtn.isSelected = true
                }
                self.aboutmeTV.text = aboutme
                self.user_id = id
                self.documentsDir(strUrl:imgUrl)
            }else {
                //No data found
            }
        }
    }
    
}

//MARK:- Profile image open gallery & Camera and set Profile image

extension EditProfileData: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    //Image alert box of gallery and camara
    @objc func imageViewTapped() {
        let alert = UIAlertController(title: "Select an Option", message: nil, preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Open Gallery", style: .default) { _ in
            self.openGallery()
        }
        alert.addAction(galleryAction)
        
        let cameraAction = UIAlertAction(title: "Open Camera", style: .default) { _ in
            self.openCamera()
        }
        alert.addAction(cameraAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func openGallery() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension EditProfileData {
    
    
    //MARK:- For Date selecting date picker
    func openDateDatePicker(){
        datePicker1.preferredDatePickerStyle = .wheels
        datePicker1.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        dobTF.inputView = datePicker1
        datePicker1.datePickerMode = .date
        
        datePicker1.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged) // We register the target function
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneDateBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        dobTF.inputAccessoryView = toolBar
        
    }
    
    @objc func datePickerChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .full
        let strDate = dateFormatter.string(from: sender.date)
        print(strDate)
    }
    
    @objc func doneDateBtnClicked(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        dobTF.text = formatter.string(from: datePicker1.date)
        self.view.endEditing(true)
    }
    
    //MARK:- For Time selecting date picker
    
    func openTimeDatePicker(){
        datePicker2.preferredDatePickerStyle = .wheels
        birthTimeTF.inputView = datePicker2
        datePicker2.datePickerMode = .time
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [cancelBtn,flexibleBtn,doneBtn]
        birthTimeTF.inputAccessoryView = toolBar
        
    }
    
    //this is done btn in date picker
    @objc func doneBtnClicked(){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        
        formatter.timeStyle = .medium
        birthTimeTF.text = formatter.string(from: datePicker2.date)
        self.view.endEditing(true)
    }
    
    //this is cancel btn in date picker
    @objc func cancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
    
}

//MARK:- UIPicker list For Select Country,State,City
extension EditProfileData {
    
    func openCountryListData(){
        
        let toolBar = UIToolbar()
        countryPicker.showsSelectionIndicator = true
        countryTF.inputView = countryPicker
        toolBar.sizeToFit()
        
        let Done = UIBarButtonItem(title:"Done", style: .done, target: self, action: #selector(doneButtonClick))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([flexibleBtn,Done], animated: false)
        countryTF.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonClick(){
        let selectedItem = countriesArr[countryPicker.selectedRow(inComponent: 0)]
        countryTF.text = selectedItem
        countryTF.endEditing(true)
    }
    
}



// MARK: - UIPickerViewDataSource & Delegate methods

extension EditProfileData: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker {
            selectedCountryIndex = row
            selectedStateIndex = 0
            selectedCityIndex = 0
            statePicker.reloadAllComponents()
            cityPicker.reloadAllComponents()
            
        } else if pickerView == statePicker {
            selectedStateIndex = row
            selectedCityIndex = 0
            cityPicker.reloadAllComponents()
        } else {
            selectedCityIndex = row
        }
    }
    
    // MARK: - UIPickerViewDataSource methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker {
            return countriesArr[row]
            
        }else if pickerView == statePicker {
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![row]
            return state
            
        }else{
            
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![selectedStateIndex]
            let city = citiesArr[state]![row]
            return city
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == countryPicker {
            return countriesArr.count
            
        } else if pickerView == statePicker {
            let country = countriesArr[selectedCountryIndex]
            let statesInCountry = statesArr[country]!
            return statesInCountry.count
            
        } else if pickerView == cityPicker{
            
            let country = countriesArr[selectedCountryIndex]
            let state = statesArr[country]![selectedStateIndex]
            let citiesInState = citiesArr[state]!
            return citiesInState.count
            
        }
        else{
            return 0
        }
    }
}
//MARK:- Coutry Picker
extension EditProfileData{
    
    func openCoutryPickerViewList(){
        
        countryTF.inputView = countryPicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(coutrycancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        
        countryTF.inputAccessoryView = toolbar
        
    }
    
    @objc func doneButtonTapped() {
        
        let country = countriesArr[selectedCountryIndex]
        if country != countryTF.text{
            stateTF.text = ""
            cityTF.text = ""
        }else if stateTF.text == ""{
            //state & city does not select first select country
        }
        countryTF.text = country
        selectedCountry = country
        
        
        countryTF.resignFirstResponder()
        
    }
    
    @objc func coutrycancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

//MARK:- State Picker
extension EditProfileData{
    
    func openStatePickerViewList(){
        
        stateTF.inputView = statePicker
        
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneStateButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(stateCancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        stateTF.inputAccessoryView = toolbar
    }
    
    @objc func doneStateButtonTapped() {
        
        let state = statesArr[selectedCountry]![selectedStateIndex]
        
        if state != stateTF.text{
            cityTF.text = ""
        }else if stateTF.text == ""{
            //city does not select
        }
        stateTF.text = state
        selectedState = state
        
        stateTF.resignFirstResponder()
    }
    
    @objc func stateCancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}

//MARK:- City Picker
extension EditProfileData{
    
    func openCityPickerViewList(){
        
        cityTF.inputView = cityPicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneCityButtonTapped))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cityCancelBtnClicked))
        
        let flexibleBtn = UIBarButtonItem (barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelBtn,flexibleBtn,doneBtn]
        cityTF.inputAccessoryView = toolbar
    }
    
    @objc func doneCityButtonTapped() {
        
        let city = citiesArr[selectedState]![selectedCityIndex]
        cityTF.text = city
        cityTF.resignFirstResponder()
    }
    
    @objc func cityCancelBtnClicked(){
        self.view.endEditing(true)
        self.resignFirstResponder()
    }
}
