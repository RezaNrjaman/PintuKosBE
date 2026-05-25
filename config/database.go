package config

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

// DB adalah variabel global agar bisa dipakai di controller
//var DB *gorm.DB
var DB *sql.DB

func ConnectDB() {
	// ✅ BACA FILE .env TERLEBIH DAHULU
	errEnv := godotenv.Load()
	if errEnv != nil {
		fmt.Println("Peringatan: File .env tidak ditemukan, mencoba menggunakan environment sistem...")
	}
	// Mengambil URL dari file .env (saat di laptop) atau Variables (saat di Railway)
	dsn := os.Getenv("DATABASE_URL")
	if dsn == "" {
		log.Fatal("ERROR: DATABASE_URL belum di-set!")
	}

	db, err := sql.Open("postgres", dsn)
	if err != nil {
		log.Fatal("Gagal koneksi ke database:", err)
	}

	DB = db
	fmt.Println("Berhasil terkoneksi ke Database!")
}