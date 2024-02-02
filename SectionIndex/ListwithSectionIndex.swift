//
//  ListwithSectionIndex.swift
//  SectionIndex
//
//  Created by 寒河江彪流 on 2024/02/02.
//

import SwiftUI

struct ListwithSectionIndex: View {
    // フルーツのリストを格納する配列
    var fruitsList: [String] = []
    // Viewの右端に縦に並べるアルファベット
    let alphabet: [String] = ["A","B","C","D","E","F","G",
                              "H","I","J","K","L","M","N",
                              "O","P","Q","R","S","T","U",
                              "V","W","X","Y","Z"]
    // イニシャライザ
    init() {
        // 適当なフルーツを9個ずつリストに格納
        let fruitsNames = ["Apple", "Banana", "Cherry", "Kiwy", "Lemon", "Melon"]
        for fruits in fruitsNames {
            for number in 1..<10 {
                let newFruits = fruits + String(number)
                fruitsList.append(newFruits)
            } // for ここまで
        } // for ここまで
    } // init ここまで
    
    var body: some View {
        // ScrollViewReaderを配置 指定した位置にスクロールできるようになる
        ScrollViewReader { proxy in
            // 奥から手前にレイアウト
            ZStack {
                List {
                    ForEach(fruitsList, id: \.self) { fruits in
                        Text(fruits)
                        // スクロールして表示させる要素のIDを指定
                            .id(fruits)
                    } // ForEach ここまで
                } // List ここまで
                // 水平方向にレイアウト
                HStack {
                    // 右に寄せる
                    Spacer()
                    // 縦方向にレイアウト
                    VStack {
                        ForEach(alphabet, id: \.self) { letter in
                            Button {
                                if let foundFruits = findFruits(firstLetter: letter) {
                                    proxy.scrollTo(foundFruits, anchor: UnitPoint(x: 0, y: 0))
                                } // if let ここまで
                            } label: {
                                // ラベル
                                Text(letter)
                                    .font(.system(size: 15))
                                    .padding(.trailing, 7)
                            } // Button ここまで
                        } // ForEach ここまで
                    } // VStack ここまで
                } // HStack ここまで
            } // ZStack ここまで
        } // ScrollViewReader ここまで
    } // body ここまで
    
    // 1文字目が指定したアルファベットで始まるフルーツをリストから探すメソッド
    private func findFruits(firstLetter: String) -> String? {
        for fruits in fruitsList {
            if fruits.prefix(1) == firstLetter {
                return fruits
            } // if ここまで
        } // for ここまで
        return nil
    } // findFruits ここまで
} // ListwithSectionIndex

#Preview {
    ListwithSectionIndex()
}
