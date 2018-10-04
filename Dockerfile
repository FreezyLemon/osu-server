FROM microsoft/dotnet:2.1-sdk

WORKDIR /app

COPY ./ .

RUN dotnet build ./osu.Server.sln -c Release
RUN cp -r ./osu.Server.DifficultyCalculator/bin/Release/netcoreapp2.0/ ./build/

WORKDIR /app/build

FROM microsoft/dotnet:2.1-runtime-alpine

# Not necessary for a dev server, but might be useful nonetheless
# RUN apk update && apk upgrade

CMD ["dotnet", "./osu.Server.DifficultyCalculator.dll"]
