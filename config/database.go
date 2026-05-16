package config

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

// DB adalah variabel global agar bisa dipakai di controller
var DB *sql.DB

func ConnectDB() {
	var err error
	//===============DB CONNECT===================
	connStr := "postgresql://postgres:vyusobUOdtQMerjxQifcArqncKAnhoil@postgres.railway.internal:5432/railway"
	
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