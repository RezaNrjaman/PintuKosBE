package controllers

import (
	"fmt"
	"net/http"
	"pintukos-backend/config"
	"pintukos-backend/models"

	"github.com/gin-gonic/gin"
	"github.com/lib/pq" // Digunakan untuk membaca tipe data Array (Fasilitas) dari PostgreSQL
)

// Fungsi untuk Beranda (Mengambil semua list kos + Filter)
func GetKosList(c *gin.Context) {
	// 1. Ambil parameter dari URL (jika ada)
	search := c.Query("search")

	// Query SQL disesuaikan (price diganti rating)
	query := "SELECT id, name, rating, location, description, facilities, wa_number FROM kos WHERE 1=1"
	var args []interface{}
	argCount := 1

	if search != "" {
		query += fmt.Sprintf(" AND (name ILIKE $%d OR location ILIKE $%d OR description ILIKE $%d)", argCount, argCount, argCount)
		args = append(args, "%"+search+"%")
		argCount++
	}

	query += " ORDER BY id ASC"

	rows, err := config.DB.Query(query, args...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengambil data"})
		return
	}
	defer rows.Close()

	var kosList []gin.H
	for rows.Next() {
		var id int
		var name, location, description, facilities, waNumber string
		var rating float64 // Tambahkan variabel tampung untuk rating
		
		if err := rows.Scan(&id, &name, &rating, &location, &description, &facilities, &waNumber); err == nil {
			kosList = append(kosList, gin.H{
				"id":          id,
				"name":        name,
				"rating":      rating, // Masukkan rating ke JSON respons
				"location":    location,
				"description": description,
				"facilities":  facilities,
				"wa_number":   waNumber,
			})
		}
	}

	// 6. Jika tidak ada kos yang cocok dengan filter, kirim array kosong agar Flutter tidak error
	if len(kosList) == 0 {
		c.JSON(http.StatusOK, []gin.H{})
		return
	}

	// 7. Kirim data yang sukses ke Flutter
	c.JSON(http.StatusOK, kosList)
}

// Fungsi untuk Halaman Detail (Mengambil 1 kos secara spesifik berdasarkan ID)
func GetKosDetail(c *gin.Context) {
	id := c.Param("id")
	
	var k models.Kos
	var facilities pq.StringArray

	// Scan langsung dimasukkan ke dalam k.Rating tanpa konversi string manual
	query := "SELECT id, name, rating, location, description, facilities, wa_number FROM kos WHERE id = $1"
	err := config.DB.QueryRow(query, id).Scan(
		&k.ID, &k.Name, &k.Rating, &k.Location, &k.Description, &facilities, &k.WaNumber,
	)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Kos tidak ditemukan"})
		return
	}

	k.Facilities = facilities
	c.JSON(http.StatusOK, k)
}