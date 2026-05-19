package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"strings" // Digunakan untuk memodifikasi teks nomor HP

	"pintukos-backend/config" // Import koneksi DB dari project kamu

	"github.com/lib/pq"
)

// 1. Struktur Pertama: Menangkap data dari pencarian awal (mengambil PlaceID)
type PlacesResponse struct {
	Results []struct {
		Name             string  `json:"name"`
		FormattedAddress string  `json:"formatted_address"`
		Rating           float64 `json:"rating"`
		PlaceID          string  `json:"place_id"` // <--- KUNCI PENTING
	} `json:"results"`
	Status string `json:"status"`
}

// 2. Struktur Kedua: Menangkap detail nomor HP
type PlaceDetailsResponse struct {
	Result struct {
		FormattedPhoneNumber string `json:"formatted_phone_number"`
	} `json:"result"`
	Status string `json:"status"`
}

func main() {
	fmt.Println("Mencoba terhubung ke database...")
	config.ConnectDB()

	// Ganti dengan API Key milikmu
	apiKey := "AIzaSyBN6V5jlX9RWTrAcLtSYAmyYRfk8cIV7_8"

	fmt.Println("Mengambil data kos di sekitar Setiabudi Bandung dari Google Maps...")

	// TAHAP 1: Cari daftar kos
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
		log.Fatalf("Gagal mengurai JSON: %v", err)
	}

	if placesData.Status != "OK" {
		log.Fatalf("API Error. Status: %s.", placesData.Status)
	}

	fmt.Printf("Ditemukan %d tempat. Memulai proses insert...\n\n", len(placesData.Results))

	for _, place := range placesData.Results {
		// TAHAP 2: Minta nomor HP ke Google menggunakan PlaceID
		detailUrl := fmt.Sprintf("https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&fields=formatted_phone_number&key=%s", place.PlaceID, apiKey)
		detailResp, errDetail := http.Get(detailUrl)
		
		waNumber := "" // Default kosong (jika tidak ada di maps)

		if errDetail == nil {
			detailBody, _ := io.ReadAll(detailResp.Body)
			var detailsData PlaceDetailsResponse
			json.Unmarshal(detailBody, &detailsData)

			if detailsData.Result.FormattedPhoneNumber != "" {
				phone := detailsData.Result.FormattedPhoneNumber
				
				// Bersihkan spasi dan strip (misal: 0812 3456-7890 menjadi 081234567890)
				phone = strings.ReplaceAll(phone, " ", "")
				phone = strings.ReplaceAll(phone, "-", "")

				// Ubah angka 0 di depan jadi +62 agar WhatsApp berfungsi
				if strings.HasPrefix(phone, "0") {
					phone = "+62" + phone[1:]
				}
				waNumber = phone
			}
			detailResp.Body.Close()
		}

		price := 1
		desc := fmt.Sprintf("Kos strategis, Rating Google: %.1f. Diambil otomatis dari Google Maps.", place.Rating)
		facilities := pq.StringArray{"Kasur", "Lemari", "Kamar Mandi Dalam", "Wi-Fi"}

		// Eksekusi insert (menyimpan waNumber)
		queryInsert := `
			INSERT INTO kos (name, price, location, description, facilities, wa_number) 
			VALUES ($1, $2, $3, $4, $5, $6)
		`
		
		_, errExec := config.DB.Exec(queryInsert, place.Name, price, place.FormattedAddress, desc, facilities, waNumber)
		
		if errExec != nil {
			log.Printf("[GAGAL] insert kos '%s'\n", place.Name)
		} else {
			if waNumber != "" {
				fmt.Printf("[SUKSES] %s (Disimpan dengan no: %s)\n", place.Name, waNumber)
			} else {
				fmt.Printf("[SUKSES] %s (Tidak ada nomor HP)\n", place.Name)
			}
		}
	}
	
	fmt.Println("\n[SELESAI] Proses sinkronisasi data dari Google Maps selesai!")
}