//
//  TabBarBuilder.swift
//  BankingTrainingVIPER
//
//  Created by Sayooj Krishnan  on 04/08/21.
//
import UIKit

struct MoreBuilder : BaseModuleBuilder {
    static func build() -> UIViewController {
        let more = More()
        more.tabBarItem.title = "Account"
        more.tabBarItem.image = UIImage(systemName: "list.dash")
        return more
    }
}
