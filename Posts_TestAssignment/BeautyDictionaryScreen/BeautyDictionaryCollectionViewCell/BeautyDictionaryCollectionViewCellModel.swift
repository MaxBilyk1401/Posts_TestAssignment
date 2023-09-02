//
//  BeautyDictionaryCollectionViewCellModel.swift
//  Sisters Staging
//
//  Created by Developer on 03.08.2023.
//

import Foundation

struct BeautyDictionaryCollectionViewCellModel{
    let id = UUID()
    let tag: String
    let title: String
    
    static let mockedData: [BeautyDictionaryCollectionViewCellModel] = [
        BeautyDictionaryCollectionViewCellModel(tag: "hair", title: "Волосся"),
        BeautyDictionaryCollectionViewCellModel(tag: "face", title: "Обличчя"),
        BeautyDictionaryCollectionViewCellModel(tag: "body", title: "Тіло"),
        BeautyDictionaryCollectionViewCellModel(tag: "home", title: "Дім"),
    ]
    
    static let skinTableViewMockedData: [BeautyDictionaryTableViewCellModel] = [
        BeautyDictionaryTableViewCellModel(title: "Антиоксидант", subtitle: "Речовина, яка запобігає окисненню та пошкодженню клітин шкіри, зменшує вплив вільних радикалів та покращує загальний стан шкіри."),
        BeautyDictionaryTableViewCellModel(title: "Тонер", subtitle: "Догляд за ніжною шкірою обличчя – це, в першу чергу, очищення плюс зволоження. І засоби для цього слід підбирати відповідно до типу шкіри, щоб вона дихала, залишалася зволоженою та насичувалася корисними речовинами із твоєї улюбленої косметики."),
        BeautyDictionaryTableViewCellModel(title: "Тонер", subtitle: "Догляд за ніжною шкірою обличчя – це, в першу чергу, очищення плюс зволоження. І засоби для цього слід підбирати відповідно до типу шкіри, щоб вона дихала, залишалася зволоженою та насичувалася корисними речовинами із твоєї улюбленої косметики."),
    ]
    
    static let hairTableViewMockedData: [BeautyDictionaryTableViewCellModel] = [
        BeautyDictionaryTableViewCellModel(title: "Біотин", subtitle: "Вітамін В-комплексу, який сприяє зміцненню волосся та нігтів, покращує стан шкіри та сприяє загальному здоров'ю."),

    ]
    
    static let cosmeticTableViewMockedData: [BeautyDictionaryTableViewCellModel] = [
        BeautyDictionaryTableViewCellModel(title: "Туш", subtitle: "особлива фарба, виготовлена із сажі, що вживається для креслення і малювання."),
    ]
    
    static let homeTableViewMockedData: [BeautyDictionaryTableViewCellModel] = [
        BeautyDictionaryTableViewCellModel(title: "Дезодоранти", subtitle: "Механізм дії дезодорантів полягає в запобіганні розмноження бактерій у вологому середовищі, і в поглинанні природних запахів тіла і інших нав'язливих запахів. До складу дезодорантів часто входять дезінфікуючі і бактерицидні добавки, що знищують мікроорганізми і перешкоджають появі неприємного запаху."),
    ]
}

