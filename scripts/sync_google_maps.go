package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"

	"pintukos-backend/config" // Import koneksi DB dari project kamu

	"github.com/lib/pq"
)

// Struktur untuk menangkap data dari Google API
type PlacesResponse struct {
	Results []struct {
		Name             string  `json:"name"`
		FormattedAddress string  `json:"formatted_address"`
		Rating           float64 `json:"rating"`
	} `json:"results"`
	Status string `json:"status"`
}

func main() {
	// 1. Hubungkan ke Database PostgreSQL
	fmt.Println("Mencoba terhubung ke database...")
	config.ConnectDB()

	// 2. Tentukan API Key Google Maps
	apiKey := "AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8"
	
	if apiKey == "GANTI_DENGAN_API_KEY_GOOGLE_MAPS_KAMU" {
		log.Fatal("Kamu belum mengganti API Key! Ganti 'apiKey' di file ini dengan API Key milikmu.")
	}

	fmt.Println("Mengambil data kos di sekitar Setiabudi Bandung dari Google Maps...")

	// 3. Request ke Google Places API
	query := url.QueryEscape("kos kosan sekitar setiabudi bandung")
	apiUrl := fmt.Sprintf("https://maps.googleapis.com/maps/api/place/textsearch/json?query=%s&key=%s", query, apiKey)

	resp, err := http.Get(apiUrl)
	if err != nil {
		log.Fatalf("Gagal melakukan HTTP Request: %v", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Gagal membaca hasil response API: %v", err)
	}

	var placesData PlacesResponse
	if err := json.Unmarshal(body, &placesData); err != nil {
		log.Fatalf("Gagal mengurai (parsing) JSON: %v", err)
	}

	if placesData.Status != "OK" {
		log.Fatalf("API Error dari Google. Status: %s. Pastikan API Key valid dan Places API sudah aktif di Google Cloud Console.", placesData.Status)
	}

	fmt.Printf("Ditemukan %d tempat. Memulai proses insert ke database...\n\n", len(placesData.Results))

	// 4. Masukkan (Insert) ke Database
	for _, place := range placesData.Results {
		// Memberikan nilai default karena Google Maps hanya memberikan nama, alamat, & rating
		price := 1   // Harga default perkiraan di Setiabudi
		desc := fmt.Sprintf("Kos strategis, Rating Google: %.1f. Diambil otomatis dari Google Maps.", place.Rating)
		facilities := pq.StringArray{"Kasur", "Lemari", "Kamar Mandi Dalam", "Wi-Fi"} // Fasilitas standar
		waNumber := "+6281234567890" // Nomor dummy, bisa diedit nanti di admin panel

		// SQL Query
		queryInsert := `
			INSERT INTO kos (name, price, location, description, facilities, wa_number) 
			VALUES ($1, $2, $3, $4, $5, $6)
		`
		
		// Eksekusi insert
		_, err := config.DB.Exec(queryInsert, place.Name, price, place.FormattedAddress, desc, facilities, waNumber)
		
		if err != nil {
			log.Printf("❌ Gagal insert kos '%s': %v\n", place.Name, err)
		} else {
			fmt.Printf("✅ Berhasil menyimpan: %s\n", place.Name)
		}
	}
	
	fmt.Println("\n🎉 Proses sinkronisasi data dari Google Maps selesai!")
}
