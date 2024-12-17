package main

import (
	"example.com/cryptit/decrypt"
	"example.com/cryptit/encrypt"
	"fmt"
	"github.com/pborman/uuid"
)

func main() {
	uuid := uuid.NewRandom()
	fmt.Println(uuid)
	encryptedStr := encrypt.Nimbus(uuid.String())
	fmt.Println(encryptedStr)
	fmt.Println(decrypt.Nimbus(encryptedStr))
}
