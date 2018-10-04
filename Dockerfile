FROM microsoft/dotnet:2.1-sdk

WORKDIR /app

COPY ./ .

RUN dotnet publish ./osu.Server.sln -c Release -v quiet

FROM microsoft/dotnet:2.1-runtime-alpine

WORKDIR /var/dotnet

COPY --from=0 /app/osu.Server.DifficultyCalculator/bin/Release/netcoreapp2.1/publish/ ./

# Not necessary for a dev server, but might be useful nonetheless
# RUN apk update && apk upgrade

CMD ["dotnet", "./osu.Server.DifficultyCalculator.dll"]
