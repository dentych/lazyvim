package main

import "fmt"

func main() {
    fmt.Println(fullName("Dennis", "Tychsen"))
}

func fullName(first, last string) string {
    return fmt.Sprintf("%s %s", first, last)
}
