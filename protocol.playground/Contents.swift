protocol SoyMilkGetable {
    func giveMeSoyMilk()
}

class Brunch: SoyMilkGetable {
    func giveMeSoyMilk() {
        print("Soy Milk")
    }
}

let aBrunch = Brunch()
aBrunch.giveMeSoyMilk()

protocol MoneyTransferProtocol {
    func giveMoney()
}

class RichPeople: MoneyTransferProtocol {
    func giveMoney() {
        print("Give you $100")
    }
}

class PoorGuy {
    var helper: MoneyTransferProtocol?

    func needMoney() {
        helper?.giveMoney()
    }
}

class NormalPeople: MoneyTransferProtocol {
    func giveMoney() {
        print("Give you $10")
    }
}

let aPoorGuy = PoorGuy()
let aRichMan = RichPeople()
let aNormalMan = NormalPeople()
aPoorGuy.helper = aRichMan
aPoorGuy.needMoney()
aPoorGuy.helper = aNormalMan
aPoorGuy.needMoney()
