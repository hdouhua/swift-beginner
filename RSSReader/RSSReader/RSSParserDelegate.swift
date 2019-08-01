//
//  RSSParserDelegate.swift
//  RSSReader
//
//  Created by Yilin on 2019/7/30.
//  Copyright © 2019 Yilin. All rights reserved.
//

import Foundation

class RSSParserDelegate: NSObject, XMLParserDelegate {
    var currentItem: NewsItem?
    var currentElementValue: String?
    var resultsArray = [NewsItem]()

    func parser(_: XMLParser, didStartElement elementName: String, namespaceURI _: String?, qualifiedName _: String?, attributes _: [String: String] = [:]) {
        if elementName == "item" {
            currentItem = NewsItem()
        } else if elementName == "title" || elementName == "link" {
            currentElementValue = nil
        }
    }

    func parser(_: XMLParser, didEndElement elementName: String, namespaceURI _: String?, qualifiedName _: String?) {
        if elementName == "item" {
            if currentItem != nil {
                resultsArray.append(currentItem!)
                currentItem = nil
            }
        } else if elementName == "title" {
            currentItem?.title = currentElementValue
        } else if elementName == "link" {
            currentItem?.link = currentElementValue
        }

        currentElementValue = nil
    }

    func parser(_: XMLParser, foundCharacters string: String) {
        if currentElementValue == nil {
            currentElementValue = string
        } else {
            currentElementValue = currentElementValue! + string
        }
    }

    func getResults() -> [NewsItem] {
        return resultsArray
    }
}
