package main

import (
	"pintukos-backend/config"
	"pintukos-backend/routes"
)

func main() {
	// 1. Hubungkan Database
	config.ConnectDB()

	// 2. Siapkan Rute API
	r := routes.SetupRoutes()

	// 3. Jalankan Server
	r.Run(":8081")
}