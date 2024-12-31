package main

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

func checkError(err error) {
	if err != nil {
		panic(err)
	}
}

type Data struct {
	Id   int
	Name string
}

func main() {
	connectionString := fmt.Sprintf("%v:%v@tcp(%v:%v)/%v", DBUser, DBPassword, DBHost, DBPort, DBName)
	db, err := sql.Open("mysql", connectionString)
	checkError(err)
	defer db.Close()

	rows, err := db.Query("select * from data")
	checkError(err)

	for rows.Next() {
		var data Data
		err := rows.Scan(&data.Id, &data.Name)
		checkError(err)
		fmt.Println(data)
	}
}
