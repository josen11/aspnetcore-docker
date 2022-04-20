# image to build app with the alias build
FROM mcr.microsoft.com/dotnet/sdk AS build
# Working directory para este punto
WORKDIR /code
# Copiamos todos los archivos al working directory /code
COPY . .
# Corremos este codigo para restore nuget pagackes y dependencies 
RUN dotnet restore
# Corremos este codigo para publicar nuestra aplicacion en la carpeta /output con la configuracion en Release
RUN dotnet publish --output /output --configuration Release
# Nos movemos aa la misma imagen
FROM mcr.microsoft.com/dotnet/aspnet
# Copiamos desde la imagen build donde construimos todo la carpeta /output hacia la carpeta /app
COPY --from=build /output /app
# Elegimos como Working directory a /app
WORKDIR /app
# Especificamos el Entrypoint donde indicamos el comando y tambien el generated dll (nombre de la aplicacion.dll)
ENTRYPOINT ["dotnet", "AspNetCoreOnDocker.dll"]