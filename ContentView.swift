//Created by Halbus Development

import SwiftUI
import FirebaseAuth

struct ContentView: View {
  //  @ObservedObject var matchFBListVM: MatchFBListViewModel
    
    
    var body: some View {
        
        ItemListView()
        
//        VStack {
//            List{
//                ForEach (matchFBListVM.matchFB) { task in
//                    
//                    VStack {
//                        Text(task.myDate, format: Date.FormatStyle(date: .numeric))
//                            .foregroundStyle(Color.primary)
//                            .font(.title2)
//                        
//                        HStack {
//                            
//                            VStack(alignment: .leading) {
//                                Text(task.playerOne)
//                                Text(task.playerTwo)
//                                Text(task.finalScoreOne.description)
//                                    .foregroundStyle(task.finalScoreOne >= task.finalScoreTwo ? Color.green : Color.red)
//                            }
//                            
//                            Spacer()
//                            
//                            VStack(alignment: .trailing) {
//                                Text(task.playerThree)
//                                Text(task.playerFour)
//                                Text(task.finalScoreTwo.description)
//                                    .foregroundStyle(task.finalScoreTwo >= task.finalScoreOne ? Color.green : Color.red)
//                            }
//                        }
//                        .foregroundStyle(Color.primary)
//                        .font(.title2)
//                        .padding(.horizontal, 10)
//                        .padding(.bottom, 20)
//                    }
//                    .padding(.top, 10)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .inset(by: 2)
//                            .stroke(Color.cardColor, lineWidth: 2)
//                    )
//
//                }
//            } .cornerRadius(20)
//            .frame(width: 350, height: 500)
//        }
    }
}

#Preview {
    ContentView()
}
