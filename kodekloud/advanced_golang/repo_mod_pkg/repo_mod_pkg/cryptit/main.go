package main

import (
	"example.com/cryptit/decrypt"
	"example.com/cryptit/encrypt"
	"fmt"
)

func main() {
	encryptedStr := encrypt.Nimbus("hello")
	fmt.Println(encryptedStr)
	fmt.Println(decrypt.Nimbus(encryptedStr))
}
