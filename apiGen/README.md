# API Generation 

Generation is done via the [swagger spec](https://github.com/swagger-api/swagger-codegen)

## Mechanism
To generate the required Http endpoint stubs from the swagger api.

## Benefits
1. Avoids developer silly mistakes
2. Spec first development
3. Removal of boiler plate repitition
4. Hopfully faster development


## Steps
 
1. Take the swagger API and put it as a file as 
   
        <root project>/apiGen/api/swagger.yaml

2. Run the script
   
        <root project>/apiGen/api/Gen.sh

This should generate

        <root project>/server/server.go
        <root project>/server/logger.go

3. Get coding those enpoints!
   
