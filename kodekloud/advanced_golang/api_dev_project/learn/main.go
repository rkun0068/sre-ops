package main

import (
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/mux"
)

type Product struct {
	Id       string
	Name     string
	Price    float64
	Quantity int
}

var Products []Product

func returnAllProducts(w http.ResponseWriter, r *http.Request) {
	log.Println("Endpoint Hit: returnAllProducts")
	json.NewEncoder(w).Encode(Products)
}

func getProduct(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	log.Println(vars)
	key := vars["id"]
	for _, product := range Products {
		if string(product.Id) == key {
			json.NewEncoder(w).Encode(product)
		}
	}

}
func handleRequest() {
	myRouter := mux.NewRouter().StrictSlash(true)

	myRouter.HandleFunc("/products", returnAllProducts)
	myRouter.HandleFunc("/product/{id}", getProduct)
	http.ListenAndServe(":10000", myRouter)
}

func main() {

	Products = []Product{
		{Id: "1", Name: "Chair", Quantity: 100, Price: 100.00},
		{Id: "2", Name: "Desk", Quantity: 200, Price: 200.00},
	}
	handleRequest()
}
