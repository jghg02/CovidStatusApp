//
//  AppDelegate.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 30-03-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let popover = NSPopover()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("IconStatusBar"))
            button.action = #selector(togglePopover(_:))
        }
        print("🛹"+"❄️")
        
        popover.contentViewController = StatusViewController.freshController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }

    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }

}

