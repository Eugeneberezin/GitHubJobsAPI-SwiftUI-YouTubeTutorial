//
//  JobView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/22/21.
//
import SDWebImageSwiftUI
import SwiftUI

struct JobView: View {
    let job: Job
    var image = WebImage(url: URL(string: ""), options: .delayPlaceholder)
    var buttonColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
            HStack(alignment: .center) {
                image
                    .resizable()
                    .placeholder(Image("placeholder")
                                    .resizable()
                                 
                                 
                    )
                    .frame(width: 100, height: 80, alignment: .leading)
                    .padding(.leading)
                
                VStack(alignment: .leading) {
                    Text(job.company)
                        .foregroundColor(Color(UIColor.label))
                        .lineLimit(2)
                        .font(.headline)
                        .padding([.top, .bottom], 1)
                    Text(job.title)
                        .foregroundColor(Color(UIColor.label))
                        .font(.headline)
                        .padding(.bottom, 1.0)
                    Text("Type: \(job.type ?? "N/A")")
                        .foregroundColor(Color(UIColor.label))
                        .padding(.bottom, 1)
                    Text(job.createdAt?.prefix(10) ?? "N/A")
                        .foregroundColor(Color(UIColor.label))
                        .padding(.bottom, 1)
                    Text("Location: \(job.location ?? "N/A")")
                        .foregroundColor(Color(UIColor.label))
                        .font(.body)
                    Link("Company Details Link", destination: (URL(string: job.url ?? "") ?? URL(string: ""))!)
                        .padding(.bottom, 5)
                }
                Spacer()
                Button(action: {
                    //add code later
                }, label: {
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(buttonColor)
                    
                })
                .padding()
            }
            
            
        }
        .padding(2)
        
    }
}

struct JobView_Previews: PreviewProvider {
    static var previews: some View {
        JobView(job: Job(company: "Test", title: "iOS Dev"), buttonColor: .gray)
    }
}
