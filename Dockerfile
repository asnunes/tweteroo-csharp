# Use the official .NET Core SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy the CSPROJ file and restore any dependencies (via NuGet)
COPY *.csproj ./
RUN dotnet restore

# Install ef to run migrations
RUN dotnet tool install --global dotnet-ef
ENV PATH="${PATH}:/root/.dotnet/tools"

COPY . ./

# Build the app and publish it to a folder called "dist"
RUN dotnet publish -c Release -o dist

# Use the official runtime image for .NET Core, which contains the ASP.NET Core runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# Copy the app's published folder from the build env
COPY --from=build-env /app/dist .

# Start the app
CMD ["dotnet", "stonepoc.dll"]


