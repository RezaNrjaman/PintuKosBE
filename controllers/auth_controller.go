package controllers

import (
	"database/sql"
	"net/http"
	"pintukos-backend/config"
	"pintukos-backend/models"
	"time"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

// Kunci rahasia untuk membuat token (Jangan disebar!)
var jwtKey = []byte("kunci_rahasia_pintukos_unpas")

// Fungsi 1: REGISTRASI AKUN BARU
func Register(c *gin.Context) {
	var user models.User
	if err := c.ShouldBindJSON(&user); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Format data salah"})
		return
	}

	// Acak (Hash) Password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengacak password"})
		return
	}

	// Simpan ke Database PostgreSQL
	_, err = config.DB.Exec("INSERT INTO users (name, email, password_hash) VALUES ($1, $2, $3)", user.Name, user.Email, string(hashedPassword))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Email mungkin sudah terdaftar"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Registrasi Berhasil! Silakan Login."})
}

// Fungsi 2: LOGIN & DAPATKAN TOKEN
func Login(c *gin.Context) {
	var requestUser models.User
	if err := c.ShouldBindJSON(&requestUser); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Format data salah"})
		return
	}

	var dbUser models.User
	var hashedPassword string

	// Cari email di database
	err := config.DB.QueryRow("SELECT id, name, email, password_hash FROM users WHERE email = $1", requestUser.Email).Scan(&dbUser.ID, &dbUser.Name, &dbUser.Email, &hashedPassword)
	if err == sql.ErrNoRows {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Email tidak ditemukan"})
		return
	}

	// Cek kecocokan password asli dengan yang di-hash
	err = bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(requestUser.Password))
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Password salah!"})
		return
	}

	// Jika sukses, buat Token JWT
	expirationTime := time.Now().Add(24 * time.Hour) // Token berlaku 24 jam
	claims := &jwt.RegisteredClaims{
		Subject:   dbUser.Email,
		ExpiresAt: jwt.NewNumericDate(expirationTime),
	}
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
	tokenString, _ := token.SignedString(jwtKey)

	// Kirim Token dan info User ke Flutter
	c.JSON(http.StatusOK, gin.H{
		"message": "Login Sukses!",
		"token":   tokenString,
		"user":    dbUser,
	})
}

// Fungsi untuk mengambil data profil pengguna yang sedang login
func GetProfile(c *gin.Context) {
	userEmail, exists := c.Get("user_email") 
	
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Tidak ada akses. Token tidak valid."})
		return
	}

	var id int
	var name, email string

	query := "SELECT id, name, email FROM users WHERE email = $1"
	err := config.DB.QueryRow(query, userEmail).Scan(&id, &name, &email)

	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Data pengguna tidak ditemukan di database."})
		return
	}


	c.JSON(http.StatusOK, gin.H{
		"id":    id,
		"name":  name,
		"email": email,
	})
}

func UpdateProfile(c *gin.Context) {
    // 1. Ambil ID User dari Token JWT (asumsi email ada di context dari middleware)
    email, _ := c.Get("email") 
    
    var input struct {
        Name  string `json:"name"`
        Email string `json:"email"`
    }

    if err := c.ShouldBindJSON(&input); err != nil {
        c.JSON(http.StatusBadRequest, gin.H{"error": "Data tidak valid"})
        return
    }

    // 2. Update database
    query := "UPDATE users SET name = $1, email = $2 WHERE email = $3"
    _, err := config.DB.Exec(query, input.Name, input.Email, email)
    if err != nil {
        c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal update profil"})
        return
    }

    c.JSON(http.StatusOK, gin.H{"message": "Profil berhasil diperbarui"})
}