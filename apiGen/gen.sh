
export set codeGenFile=swagger-codegen-cli.jar

# Download the swagger code gen binary if not in the local directory
if [ ! -f ${codeGenFile} ]; then
    echo " downloading binary for Api Stub creation"
    wget https://repo1.maven.org/maven2/io/swagger/swagger-codegen-cli/2.4.17/swagger-codegen-cli-2.4.17.jar -O ${codeGenFile}
    chmod 755 "./${codeGenFile}"
    else 
    echo "Not downloading binary, you already have it"
fi

# Use the code gen to generat the stub 
echo "Generating stub START"
    java -jar "./${codeGenFile}" generate -i ./api/swagger.yaml -l go-server -o ./stubbed
echo "Generating stub FINISH"

echo "Moving http stubs from gen to service START"


if [ ! -d ../server ]; then 
        mkdir ../server
fi

cp ./stubbed/go/routers.go ../server/routers.go 
cp ./stubbed/go/logger.go  ../server/logger.go
sed -i 's/swagger/server/g' ../server/routers.go
sed -i 's/swagger/server/g' ../server/logger.go

echo "Moving http stubs from gen to service FINISH"
