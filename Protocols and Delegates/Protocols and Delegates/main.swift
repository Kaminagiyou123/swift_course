

protocol AdvanceLifeSupport {
    func performCPR ()
}

class EmergencyCallHandler {
    var delegate: AdvanceLifeSupport?
    func assessSituation (){
        print ("Can you tell me what happened")
    }
    func medicalEmergency (){
        delegate?.performCPR()
    }
}

struct Paramedic: AdvanceLifeSupport{
    init(handler:EmergencyCallHandler){
        handler.delegate=self
    }
    func performCPR() {
        print("The paramedic starts performing CPR")
    }
}

class Doctor:AdvanceLifeSupport{
    init (handler:EmergencyCallHandler){
        handler.delegate=self
    }
    func performCPR() {
        print("The docotor starts performing CPR")
    }
    func diagnositc(){
        print ("dignostic disease")
    }
}

class Surgeon:Doctor {
    override func performCPR() {
        super.performCPR()
        print("Singing while doing CPR")
    }
}

let emilio=EmergencyCallHandler()
let angela=Surgeon(handler: emilio)

emilio.assessSituation()
emilio.medicalEmergency()


