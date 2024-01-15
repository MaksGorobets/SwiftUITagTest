//
//  ContentView.swift
//  TestingApp
//
//  Created by Maks Winters on 10.01.2024.
//
// https://ishtiz.com/swiftui/custom-color-picker-in-swiftui
//
// https://medium.com/geekculture/tags-view-in-swiftui-e47dc6ce52e8
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView(.vertical) {
                    VStack{
                        VStack(alignment: .leading, spacing: 4) {
                            ForEach(viewModel.rows, id:\.self) { rows in
                                HStack(spacing: 6) {
                                    ForEach(rows){ row in
                                        Text(row.name)
                                            .fixedSize()
                                            .foregroundStyle(.white)
                                            .font(.system(size: 16))
                                            .padding(.leading, 14)
                                            .padding(.trailing, 30)
                                            .padding(.vertical, 10)
                                            .background(
                                                ZStack(alignment: .trailing){
                                                    Capsule()
                                                        .fill(row.color.gradient)
                                                    Button{
                                                        viewModel.removeTag(by: row.id)
                                                    } label:{
                                                        Image(systemName: "xmark")
                                                            .frame(width: 15, height: 15)
                                                            .padding(.trailing, 10)
                                                            .foregroundColor(.white)
                                                    }
                                                }
                                            )
                                            .shadow(radius: 3)
                                    }
                                    Spacer()
                                }
                                .frame(height: 28)
                                .padding(.bottom, 15)
                            }
                        }
                        .padding(24)
                        
                        Spacer()
                    }
                }
                VStack {
                    if viewModel.isShowingSelectior {
                        CustomColorPicker(selectedColor: $viewModel.selectedColor)
                    }
                    HStack {
                        TextField("Enter tag", text: $viewModel.tagText, onCommit: {
                            viewModel.addTag()
                        })
                        .autocorrectionDisabled()
                        .onChange(of: viewModel.tagText) {
                            viewModel.limitTextField()
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .strokeBorder()
                                .foregroundColor(.primary)
                        )
                        Button {
                            withAnimation {
                                viewModel.isShowingSelectior.toggle()
                            }
                        } label: {
                            Circle()
                                .stroke(lineWidth: 2)
                                .fill(.primary)
                                .frame(height: 55)
                                .overlay(
                                    Circle()
                                        .fill(viewModel.selectedColor)
                                        .frame(width: 20)
                                )
                        }
                        .buttonStyle(.plain)
                        Button {
                            viewModel.addTag()
                        } label: {
                            Circle()
                                .stroke(lineWidth: 1)
                                .fill(.primary)
                                .frame(height: 55)
                                .overlay(
                                    Image(systemName: "plus")
                                        .foregroundStyle(.primary)
                                        .font(.system(size: 20))
                                )
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
            }
            .navigationTitle("Tag Test")
        }
    }
}

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color] = [.purple,
                           .red,
                           .orange,
                           .yellow,
                           .green,
                           .blue]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        self.selectedColor = color
                    }) {
                        Circle()
                            .fill(color)
                            .frame(width: 50, height: 50)
                            .overlay(
                                Circle()
                                    .stroke(Color.primary, lineWidth: self.selectedColor == color ? 3 : 0)
                            )
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
