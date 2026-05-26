package controllers

import (
	"fmt"
	"net/http"
	"pintukos-backend/config"
	"pintukos-backend/models"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/lib/pq"
)

// Fungsi untuk Beranda
func GetKosList(c *gin.Context) {
	search := c.Query("search")

	query := `SELECT id, name, rating, location, description, COALESCE(wa_number, ''), 
			  COALESCE(latitude, 0), COALESCE(longitude, 0), COALESCE(image_urls, '{}') 
			  FROM kos WHERE 1=1`
	var args []interface{}
	argCount := 1

	if search != "" {
		search = strings.TrimSpace(search)
		
		words := strings.Fields(search)

		for _, word := range words {
			wordLower := strings.ToLower(word)

			// Jika yang diketik adalah variasi kata "kos", kita sapu bersih dengan '%kos%'
			if wordLower == "kos" || wordLower == "kost" || wordLower == "kosan" || wordLower == "kostan" {
				query += ` AND (name ILIKE '%kos%' OR location ILIKE '%kos%' OR description ILIKE '%kos%')`
			} else {
				// Untuk kata tambahan (misal: nama daerah seperti "setiabudi"), cari secara spesifik
				query += fmt.Sprintf(" AND (name ILIKE $%d OR location ILIKE $%d OR description ILIKE $%d)", argCount, argCount, argCount)
				args = append(args, "%"+word+"%")
				argCount++
			}
		}
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
		var imageURLs pq.StringArray 

		if err := rows.Scan(&id, &name, &rating, &location, &description, &waNumber, &lat, &lng, &imageURLs); err == nil {
			kosList = append(kosList, gin.H{
				"id":          id,
				"name":        name,
				"rating":      rating,
				"location":    location,
				"description": description,
				"wa_number":   waNumber,
				"latitude":    lat,
				"longitude":   lng,
				"image_urls":  []string(imageURLs), 
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
	var imageURLs pq.StringArray

	query := `SELECT id, name, rating, location, description, COALESCE(wa_number, ''), 
			  COALESCE(latitude, 0), COALESCE(longitude, 0), COALESCE(image_urls, '{}') 
			  FROM kos WHERE id = $1`

	err := config.DB.QueryRow(query, id).Scan(
		&k.ID, &k.Name, &k.Rating, &k.Location, &k.Description, &k.WaNumber, &k.Latitude, &k.Longitude, &imageURLs,
	)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Kos tidak ditemukan"})
		return
	}

	k.ImageURLs = []string(imageURLs)
	c.JSON(http.StatusOK, k)
}