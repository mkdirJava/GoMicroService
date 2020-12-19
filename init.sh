
function initGoProject(){
    if [ ! -f go.mod ] ; then 
        
        # init a go module
        echo "init new go module"
        projecName=$1
        go mod init lod.${projecName}.com/${projecName}

        echo "package main" >> ./main.go

        cat >./main.go <<EOF
package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	swagger "lod.drugs.com/drugs/server"
)

func main() {
	log.Printf("Server started")
	readinessPort := os.Getenv("READINESS_PORT")
	readinessEndPoint := os.Getenv("READINESS_ENDPOINT")
	operationPort := os.Getenv("OPERATION_PORT")
	log.Fatal(http.ListenAndServe(":"+readinessPort, readiness(readinessEndPoint, readinessImpl)))
	log.Fatal(http.ListenAndServe(":"+operationPort, swagger.NewRouter()))
}

func readiness(readinessEndPoint string, readinessHandler http.HandlerFunc) *mux.Router {
	router := mux.NewRouter().StrictSlash(true)
	swagger.Logger(readinessHandler, "readniness")
	router.
		Methods("get").
		Path("/" + readinessEndPoint).
		Name("readinessProbe").
		Handler(readinessHandler)
	return router

}

func readinessImpl(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World!")
}

EOF

    else
        echo "go module already defined"
    fi
    
}

initGoProject $1

