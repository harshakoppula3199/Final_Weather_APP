import SwiftUI

struct DetailView: View {
    let location: Location

    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        ZStack {


            LinearGradient(
                colors: [
                    Color("backgroundcolour"),
                    Color("backgroundcolour").opacity(0.7)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 28) {

                    Text(location.name.uppercased())
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .tracking(1.2)

                    Image(systemName: location.weather.iconName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 170, height: 170)
                        .foregroundStyle(.yellow)
                        .shadow(color: .yellow.opacity(0.4), radius: 12)

                    
                    if viewModel.isLoading {
                        ProgressView("Fetching live weather...")
                            .foregroundStyle(.white)

                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)

                    } else {
                        Text(viewModel.temperature)
                            .font(.system(size: 52, weight: .bold))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.3), radius: 6)
                        VStack(spacing: 18) {

                            detailRow("Humidity", viewModel.humidity)
                            detailRow("Pressure", viewModel.pressure)
                            detailRow("Wind (80 m)", viewModel.windSpeed)
                            detailRow("Visibility", viewModel.visibility)
                            detailRow("Precipitation", viewModel.precipitation)
                            detailRow("Soil Temp (6 cm)", viewModel.soilTemperature)

                        }
                        Button {
                            viewModel.clearWeatherCache()
                        } label: {
                            Text("Clear Cached Data")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                        }
                        .padding(.top, 20)

                        .padding(20)
                        .background(
                            RoundedRectangle(cornerRadius: 22)
                                .fill(Color.white.opacity(0.18))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 22)
                                        .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                )
                                .shadow(color: .black.opacity(0.25), radius: 10, y: 6)
                            )
                    }
                }
                .padding()
            }
        }
        .task {
            await viewModel.loadWeather(
                latitude: location.latitude,
                longitude: location.longitude,
                cityName: location.name
            )
        }
    }

    private func detailRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            Spacer()

            Text(value)
                .font(.subheadline.bold())
                .foregroundStyle(.white)
        }
    }
}

