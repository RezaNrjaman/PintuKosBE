package config

import (
	"fmt"
	"log"
	"os"

	_ "github.com/lib/pq"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

// DB adalah variabel global agar bisa dipakai di controller
var DB *gorm.DB

func ConnectDB() {
	// Mengambil URL dari file .env (saat di laptop) atau Variables (saat di Railway)
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		log.Fatal("ERROR: DATABASE_URL belum di-set!")
	}

	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Gagal koneksi ke database:", err)
	}

	DB = db
	fmt.Println("Berhasil terkoneksi ke Database!")
}