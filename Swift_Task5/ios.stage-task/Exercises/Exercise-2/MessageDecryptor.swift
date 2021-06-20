import UIKit

class MessageDecryptor: NSObject {
    
    func decryptMessage(_ message: String) -> String {
        var resultMes = message,
            changedKey = false
        while true {
            var currentCount = "",
                key = 0, newMessange = "",
                currentMessage = "",
                globalKey = 0,
                i = 0
            for char in resultMes {
                if (char >= "0" && char <= "9" && key == 0) {
                    currentCount += String(char)
                } else if (char >= "0" && char <= "9" && key == 1) {
                    currentCount = String(char)
                    currentMessage = ""
                    key = 0
                } else if (char == "[" && key == 1) {
                    currentCount = ""
                    currentMessage = ""
                } else if (char == "[" && key == 0) {
                    key = 1
                } else if (char == "]") {
                    newMessange = String(resultMes.prefix(i - currentCount.count - 1 - currentMessage.count))
                    var cicleCount:Int? = Int(currentCount)
                    if (currentCount.count == 0) {
                        cicleCount = 1
                    }
                    if (cicleCount ?? 0 > 0) {
                        for _ in 1...(cicleCount ?? 0) {
                            newMessange += currentMessage
                        }
                    }
                    newMessange += String(resultMes.suffix(resultMes.count - i - 1))
                    globalKey = 1
                    changedKey = true
                    break
                } else if (key == 1) {
                    currentMessage += String(char)
                }
                i += 1
            }
            if (globalKey == 0) {
                break
            }
            resultMes = newMessange
        }
        if (changedKey) {
            return resultMes
        } else {
            return message
        }
    }
}
