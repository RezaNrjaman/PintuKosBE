package config

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/lib/pq"
)

// DB adalah variabel global agar bisa dipakai di controller
var DB *sql.DB

func ConnectDB() {
	var err error
	//===============DB CONNECT===================
	connStr := os.Getenv("DATABASE_URL")
if connStr == "" {
    connStr = "postgresql://neondb_owner:npg_qsIzM0b7nRBW@ep-sparkling-water-aobbofv7-pooler.c-2.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require"
}
	
	DB, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Gagal membaca settingan DB: ", err)
	}

	// Tes koneksi
	err = DB.Ping()
	if err != nil {
		log.Fatal("Gagal terhubung! Cek password/username kamu: ", err)
	}
	
	log.Println("MANTAP! Golang berhasil terhubung ke PostgreSQL!")
}