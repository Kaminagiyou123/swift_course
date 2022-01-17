

protocol AdvanceLifeSupport {
    func performCPR()
}

class MedicalEmergency{
    var delegate:AdvanceLifeSupport?
    
    func medicalSupport(){
        delegate?.performCPR()
        
    }
    
    
    
}

class Paramedic:AdvanceLifeSupport{
    init(handler:MedicalEmergency){
        handler.delegate=self
    }
    func performCPR() {
        print("Paramedic performing CPR")
    }
}

class Doctor:Paramedic{
    override func performCPR() {
        print("Doctor performing CPR")
    }
    
}

class Surgeon:Paramedic{
    override func performCPR() {
        print("Surgeon performing CPR")
    }
}

var ruby=MedicalEmergency()

let lily=Surgeon(handler:ruby)

ruby.medicalSupport()
