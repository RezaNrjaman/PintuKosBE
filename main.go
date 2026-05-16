package main

import (
	"net/http"
	"os"
	"pintukos-backend/config"
	"pintukos-backend/routes"

	"github.com/rs/cors"
)

func main() {
	// 1. Hubungkan Database
	config.ConnectDB()

	// 2. Siapkan Rute API
	r := routes.SetupRoutes()

	// 3. Jalankan Server
	c := cors.New(cors.Options{
        AllowedOrigins:   []string{"*"},
        AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
        AllowedHeaders:   []string{"Authorization", "Content-Type"},
        AllowCredentials: true,
    })

    handler := c.Handler(r)

    port := os.Getenv("PORT")
    if port == "" {
        port = "8081"
    }
    http.ListenAndServe("0.0.0.0:"+port, handler)
}