package controllers

import (
	"fmt"
	"net/http"
	"pintukos-backend/config"
	"pintukos-backend/models"
	"strings"

	"github.com/gin-gonic/gin"
)

// Fungsi untuk Beranda (Mengambil semua list kos + Filter)
func GetKosList(c *gin.Context) {
	search := c.Query("search")

	// ✅ Perubahan: Ambil data latitude dan longitude menggunakan COALESCE sebagai pelindung keamanan data kosong
	query := `SELECT id, name, rating, location, description, COALESCE(wa_number, ''), 
			  COALESCE(latitude, 0), COALESCE(longitude, 0) FROM kos WHERE 1=1`
	var args []interface{}
	argCount := 1

	if search != "" {
		search = strings.TrimSpace(search)
		searchLower := strings.ToLower(search)
		search = strings.ReplaceAll(searchLower, "kost", "kos")

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
		var name, location, description, waNumber string
		var rating, lat, lng float64 
		
		// ✅ Perubahan: Tambahkan scanning variabel lat dan lng
		if err := rows.Scan(&id, &name, &rating, &location, &description, &waNumber, &lat, &lng); err == nil {
			kosList = append(kosList, gin.H{
				"id":          id,
				"name":        name,
				"rating":      rating,
				"location":    location,
				"description": description,
				"wa_number":   waNumber,
				"latitude":    lat,  // ✅ Dikirim ke JSON respons
				"longitude":   lng,  // ✅ Dikirim ke JSON respons
			})
		}
	}

	if len(kosList) == 0 {
		c.JSON(http.StatusOK, []gin.H{})
		return
	}

	c.JSON(http.StatusOK, kosList)
}

// Fungsi untuk Halaman Detail
func GetKosDetail(c *gin.Context) {
	id := c.Param("id")
	
	var k models.Kos

	// ✅ Perubahan: Ambil data latitude dan longitude pada query detail
	query := `SELECT id, name, rating, location, description, COALESCE(wa_number, ''), 
			  COALESCE(latitude, 0), COALESCE(longitude, 0) FROM kos WHERE id = $1`
	err := config.DB.QueryRow(query, id).Scan(
		&k.ID, &k.Name, &k.Rating, &k.Location, &k.Description, &k.WaNumber, &k.Latitude, &k.Longitude,
	)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Kos tidak ditemukan"})
		return
	}

	c.JSON(http.StatusOK, k)
}