//
//  ViewController.swift
//  Spottydown
//
//  Created by Noah Evans on 15/07/2020.
//


import Cocoa
import Foundation




class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    
    @IBOutlet weak var locField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    
    @IBAction func download(_ sender: Any) {
        let task = Process()
        let command = "spotdl -s \"\(textField.stringValue)\" -f \"\(locField.stringValue)\""
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.arguments = ["--login", "-c", command]

        let connection = Pipe()
        task.standardOutput = connection

        do {
            try task.run()
        }
        catch {
            print("Error")
        }
    }
    

}

@discardableResult
private func shell(_ args: String) -> String {
    var outstr = ""
    let task = Process()
    task.launchPath = "/bin/zsh`"
    task.arguments = ["--login", "-c", args]
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = String(data: data, encoding: .utf8) {
        outstr = output as String
    }
    task.waitUntilExit()
    return outstr
}
