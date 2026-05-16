package middleware

import (
	"net/http"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt/v5"
)

// Kunci ini HARUS SAMA PERSIS dengan yang ada di auth_controller.go
var jwtKey = []byte("kunci_rahasia_pintukos_unpas") 

func RequireAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		// 1. Tangkap "surat izin" (Token) dari Flutter
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Akses ditolak, Anda belum login"})
			c.Abort()
			return
		}

		// 2. Bersihkan teks "Bearer " dari token
		tokenString := strings.Replace(authHeader, "Bearer ", "", 1)

		// 3. Cek keaslian Token
		token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		})

		if err != nil || !token.Valid {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Sesi Anda telah habis, silakan login ulang"})
			c.Abort()
			return
		}

		// 4. Jika asli, catat email pengguna tersebut agar bisa dipakai oleh sistem
		if claims, ok := token.Claims.(jwt.MapClaims); ok && token.Valid {
			c.Set("user_email", claims["sub"]) // "sub" adalah tempat kita menyimpan email saat login
		}

		// Silakan lewat!
		c.Next()
	}
}