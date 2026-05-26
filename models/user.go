package models

import "gorm.io/gorm"

type User struct {
	ID       int    `json:"id"`
	Name     string `json:"name"`
	Email    string `json:"email"`
	Password string `json:"password,omitempty"` // Digunakan saat menerima request
}

type UpdateProfileInput struct {
	Name string `json:"name" binding:"required"`
}

// UBAH: Fungsi khusus untuk mengupdate kolom 'name' saja berdasarkan ID User
func UpdateUserName(db *gorm.DB, userID uint, newName string) error {
	return db.Model(&User{}).Where("id = ?", userID).Update("name", newName).Error
}