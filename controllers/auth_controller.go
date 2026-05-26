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

// UpdateProfile menangani pembaruan nama menggunakan Native SQL bawaan pintukos-backend
func UpdateProfile(c *gin.Context) {
	// 1. Ambil email dari JWT token (Sama persis dengan fungsi GetProfile Anda)
	userEmail, exists := c.Get("user_email")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Tidak ada akses. Token tidak valid."})
		return
	}

	// 2. Bind JSON menggunakan struct UpdateProfileInput dari package models Anda
	var input models.UpdateProfileInput
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Nama lengkap wajib diisi"})
		return
	}

	// 3. Eksekusi query SQL menggunakan sintaks PostgreSQL ($1, $2) sesuai config.DB Anda
	query := "UPDATE users SET name = $1 WHERE email = $2"
	_, err := config.DB.Exec(query, input.Name, userEmail)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal memperbarui database"})
		return
	}

	// 4. Return status 200 OK ke Flutter
	c.JSON(http.StatusOK, gin.H{
		"message": "Profil berhasil diupdate",
		"name":    input.Name,
	})
}

// Fungsi untuk Mengganti Password
func ChangePassword(c *gin.Context) {
	// Ambil email dari token
	userEmail, exists := c.Get("user_email")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Akses ditolak. Token tidak valid."})
		return
	}

	// Tangkap input dari Flutter
	var input struct {
		OldPassword string `json:"old_password"`
		NewPassword string `json:"new_password"`
	}

	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Data tidak valid"})
		return
	}

	// Ambil password_hash lama dari database
	var hashedPassword string
	err := config.DB.QueryRow("SELECT password_hash FROM users WHERE email = $1", userEmail).Scan(&hashedPassword)
	if err != nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "User tidak ditemukan"})
		return
	}

	// Cek apakah akun ini login menggunakan Google API (OAuth)
	if hashedPassword == "google_oauth" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Akun Google tidak dapat mengubah password melalui aplikasi ini."})
		return
	}

	// Bandingkan password lama yang diketik dengan yang ada di database
	err = bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(input.OldPassword))
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Password saat ini salah!"})
		return
	}

	// Jika cocok, enkripsi (hash) password yang baru
	newHashedPassword, errHash := bcrypt.GenerateFromPassword([]byte(input.NewPassword), bcrypt.DefaultCost)
	if errHash != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal mengenkripsi password baru"})
		return
	}

	// Simpan password baru ke database
	_, errUpdate := config.DB.Exec("UPDATE users SET password_hash = $1 WHERE email = $2", string(newHashedPassword), userEmail)
	if errUpdate != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal menyimpan password ke database"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Password berhasil diperbarui!"})
}