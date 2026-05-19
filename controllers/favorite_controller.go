package controllers

import (
	"database/sql"
	"net/http"
	"pintukos-backend/config"

	"github.com/gin-gonic/gin"
)

// Fungsi bantuan: Mencari ID User berdasarkan Email dari Token JWT
func getUserIdByEmail(email string) (int, error) {
	var id int
	err := config.DB.QueryRow("SELECT id FROM users WHERE email = $1", email).Scan(&id)
	return id, err
}

// Fungsi 1: Cek Status (Apakah Kos ini sudah disukai pengguna?)
func CheckFavorite(c *gin.Context) {
	email := c.MustGet("user_email").(string) // Ambil email dari satpam/middleware
	userID, _ := getUserIdByEmail(email)
	kosID := c.Param("id")

	var isFavorite bool
	err := config.DB.QueryRow("SELECT EXISTS(SELECT 1 FROM favorites WHERE user_id = $1 AND kos_id = $2)", userID, kosID).Scan(&isFavorite)
	if err != nil {
		isFavorite = false
	}

	c.JSON(http.StatusOK, gin.H{"is_favorite": isFavorite})
}

// Fungsi 2: Klik Tombol Hati (Tambah/Hapus Favorit Otomatis)
func ToggleFavorite(c *gin.Context) {
	email := c.MustGet("user_email").(string)
	userID, err := getUserIdByEmail(email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "User tidak ditemukan"})
		return
	}

	kosID := c.Param("id")

	// Cek apakah data favorit sudah ada di database
	var favID int
	err = config.DB.QueryRow("SELECT id FROM favorites WHERE user_id = $1 AND kos_id = $2", userID, kosID).Scan(&favID)

	if err == sql.ErrNoRows {
		// Jika Belum -> Masukkan ke tabel favorites
		_, err = config.DB.Exec("INSERT INTO favorites (user_id, kos_id) VALUES ($1, $2)", userID, kosID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal menyimpan data"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"message": "Disimpan ke Favorit ❤️", "is_favorite": true})
	} else {
		// Jika Sudah -> Hapus dari tabel favorites (Un-favorite)
		_, err = config.DB.Exec("DELETE FROM favorites WHERE id = $1", favID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal menghapus data"})
			return
		}
		c.JSON(http.StatusOK, gin.H{"message": "Dihapus dari Favorit 💔", "is_favorite": false})
	}
}

// Fungsi 3: Mengambil semua daftar kos favorit milik user
func GetFavorites(c *gin.Context) {
	email := c.MustGet("user_email").(string)
	userID, err := getUserIdByEmail(email)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "User tidak ditemukan"})
		return
	}

	// Ambil data kos dengan menggabungkan (JOIN) tabel kos dan favorites
	rows, err := config.DB.Query(`
		SELECT k.id, k.name, k.price, k.location 
		FROM kos k 
		JOIN favorites f ON k.id = f.kos_id 
		WHERE f.user_id = $1
	`, userID)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengambil data favorit"})
		return
	}
	defer rows.Close()

	var favorites []gin.H
	for rows.Next() {
		var id int
		var name, price, location string
		if err := rows.Scan(&id, &name, &price, &location); err == nil {
			favorites = append(favorites, gin.H{
				"id":       id,
				"name":     name,
				"price":    price,
				"location": location,
			})
		}
	}

	// Jika kosong, kirim array kosong agar Flutter tidak error
	if len(favorites) == 0 {
		c.JSON(http.StatusOK, []gin.H{})
		return
	}

	c.JSON(http.StatusOK, favorites)
}