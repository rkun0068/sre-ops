package main

import (
	"fmt"
	"time"
)

func main() {
	go func() {
		fmt.Println("In anonymous function")
	}()
	time.Sleep(1 * time.Second)
}
