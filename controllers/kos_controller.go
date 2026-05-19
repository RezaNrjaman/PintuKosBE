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
	minPrice := c.Query("min_price")
	maxPrice := c.Query("max_price")

	// 2. Susun Query SQL Dasar
	query := "SELECT id, name, price, location, description, facilities, wa_number FROM kos WHERE 1=1"
	var args []interface{}
	argCount := 1

	// 3. Tambahkan Filter Dinamis
	if search != "" {
		query += fmt.Sprintf(" AND (name ILIKE $%d OR location ILIKE $%d OR description ILIKE $%d)", argCount, argCount, argCount)
		args = append(args, "%"+search+"%")
		argCount++
	}

	if minPrice != "" {
		// Mengubah format "Rp 1.000.000" menjadi angka 1000000 agar bisa dibandingkan
		query += fmt.Sprintf(" AND CAST(REPLACE(REPLACE(price, 'Rp ', ''), '.', '') AS INTEGER) >= $%d", argCount)
		args = append(args, minPrice)
		argCount++
	}

	if maxPrice != "" {
		query += fmt.Sprintf(" AND CAST(REPLACE(REPLACE(price, 'Rp ', ''), '.', '') AS INTEGER) <= $%d", argCount)
		args = append(args, maxPrice)
		argCount++
	}

	query += " ORDER BY id ASC" // Mengurutkan dari yang terlama dimasukkan

	// 4. Eksekusi ke Database
	rows, err := config.DB.Query(query, args...)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengambil data dari database"})
		return
	}
	defer rows.Close()

	// 5. Bungkus data hasil query ke dalam format JSON
	var kosList []gin.H
	for rows.Next() {
		var id int
		var name, price, location, description, facilities, waNumber string
		
		if err := rows.Scan(&id, &name, &price, &location, &description, &facilities, &waNumber); err == nil {
			kosList = append(kosList, gin.H{
				"id":          id,
				"name":        name,
				"price":       price,
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
	id := c.Param("id") // Menangkap ID dari URL
	
	var k models.Kos
	var priceFloat float64
	var facilities pq.StringArray // Tipe khusus agar Golang paham Array PostgreSQL

	query := "SELECT id, name, price, location, description, facilities, wa_number FROM kos WHERE id = $1"
	err := config.DB.QueryRow(query, id).Scan(
		&k.ID, &k.Name, &priceFloat, &k.Location, &k.Description, &facilities, &k.WaNumber,
	)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Kos tidak ditemukan"})
		return
	}

	k.Price = fmt.Sprintf("Rp %.0f", priceFloat)
	k.Facilities = facilities // Masukkan data array ke struct

	c.JSON(http.StatusOK, k)
}